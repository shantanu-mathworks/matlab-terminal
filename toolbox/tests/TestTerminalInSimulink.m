% Copyright 2026 The MathWorks, Inc.

classdef TestTerminalInSimulink < matlab.unittest.TestCase
    %TESTTERMINALINSIMLINK Integration tests for Terminal docked in Simulink.
    %   These tests require Simulink to be installed and a display available.
    %   They are skipped automatically when Simulink is not present.

    properties (Access = private)
        ModelName string  % temporary model created for testing
    end

    methods (TestClassSetup)
        function checkSimulinkAvailable(testCase)
            % Skip everything if Simulink is not installed.
            hasSimulink = ~isempty(ver('simulink'));
            testCase.assumeTrue(hasSimulink, ...
                'Simulink is not installed — skipping Simulink terminal tests.');
        end

        function checkCanCreateTerminal(testCase)
            % Skip if we cannot create a basic terminal (no display, no binary, etc.)
            try
                t = terminal(WindowStyle="normal");
                pause(1);
                delete(t);
            catch me
                testCase.assumeFail(sprintf( ...
                    'Cannot create Terminal (%s) — skipping Simulink tests.', ...
                    me.message));
            end
        end
    end

    methods (TestMethodSetup)
        function createTemporaryModel(testCase)
            % Create a unique temporary model for each test.
            testCase.ModelName = sprintf('terminal_test_%08x', randi(2^32 - 1));
            new_system(testCase.ModelName);
            open_system(testCase.ModelName);
            pause(1);  % let Simulink editor fully initialize
        end
    end

    methods (TestMethodTeardown)
        function cleanupModelAndTerminals(testCase)
            terminal.closeAll();
            pause(0.5);
            try
                close_system(testCase.ModelName, 0);
            catch
            end
            % Delete the temp file if it was saved.
            mdlFile = [testCase.ModelName '.slx'];
            if isfile(mdlFile)
                delete(mdlFile);
            end
        end
    end

    %% --- Constructor tests ---

    methods (Test)
        function testPlaceSimulink(testCase)
            t = terminal(Place="simulink");
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyClass(t, 'terminal');
            testCase.verifyEqual(t.Place, "simulink");
        end

        function testPlaceDefaultIsMatlab(testCase)
            t = terminal(WindowStyle="normal");
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyEqual(t.Place, "matlab");
        end

        function testModelImpliesSimulink(testCase)
            t = terminal(Model=testCase.ModelName);
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyEqual(t.Place, "simulink");
        end

        function testModelTargetsSpecificEditor(testCase)
            t = terminal(Model=testCase.ModelName);
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyClass(t, 'terminal');
        end

        function testCustomNameInSimulink(testCase)
            t = terminal(Place="simulink", Name="Build");
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyClass(t, 'terminal');
        end

        function testCustomShellInSimulink(testCase)
            if ispc
                shell = "cmd.exe";
            else
                shell = "/bin/bash";
            end
            t = terminal(Place="simulink", Shell=shell);
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyEqual(t.Shell, shell);
        end

        function testThemeInSimulink(testCase)
            t = terminal(Place="simulink", Theme="dracula");
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyEqual(t.Theme, "dracula");
        end

        function testAllOptionsInSimulink(testCase)
            if ispc
                shell = "cmd.exe";
            else
                shell = "/bin/bash";
            end
            t = terminal(Model=testCase.ModelName, Name="Full", ...
                Shell=shell, Theme="monokai");
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyEqual(t.Place, "simulink");
            testCase.verifyEqual(t.Theme, "monokai");
            testCase.verifyEqual(t.Shell, shell);
        end

        %% --- Lifecycle tests ---

        function testDeleteRemovesPanel(testCase)
            t = terminal(Place="simulink");
            testCase.verifyTrue(isvalid(t));
            delete(t);
            testCase.verifyFalse(isvalid(t));
        end

        function testListIncludesSimulinkTerminal(testCase)
            before = numel(terminal.list());
            t = terminal(Place="simulink");
            testCase.addTeardown(@() safeDelete(t));
            testCase.verifyEqual(numel(terminal.list()), before + 1);
        end

        function testCloseAllIncludesSimulinkTerminals(testCase)
            terminal(Place="simulink");
            testCase.verifyGreaterThanOrEqual(numel(terminal.list()), 1);
            terminal.closeAll();
            pause(0.5);
            testCase.verifyEmpty(terminal.list());
        end

        function testMultipleSimulinkTerminals(testCase)
            % A second terminal docked to the same model replaces the first.
            t1 = terminal(Place="simulink", Name="Term1");
            testCase.addTeardown(@() safeDelete(t1));
            t2 = terminal(Place="simulink", Name="Term2");
            testCase.addTeardown(@() safeDelete(t2));
            testCase.verifyFalse(isvalid(t1));
        end

        %% --- Error cases ---

        function testInvalidPlaceErrors(testCase)
            testCase.verifyError(...
                @() terminal(Place="invalid"), ...
                'MATLAB:validators:mustBeMember');
        end

        function testModelNotFoundErrors(testCase)
            testCase.verifyError(...
                @() terminal(Model="nonexistent_model_xyz_99"), ...
                'Terminal:ModelNotFound');
        end

        function testNoOpenModelErrors(testCase)
            % Close the temporary model, then verify the correct error.
            close_system(testCase.ModelName, 0);
            testCase.verifyError(...
                @() terminal(Place="simulink"), ...
                'Terminal:NoOpenSimulinkModel');
            % Re-open so teardown doesn't warn.
            new_system(testCase.ModelName);
            open_system(testCase.ModelName);
            pause(0.5);
        end
    end
end

%% --- Helpers ---

function safeDelete(t)
    if isvalid(t)
        delete(t);
    end
end
