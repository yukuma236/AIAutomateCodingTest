# Implement Task

Implement the approved plan.

Before implementation:

1. Reconfirm the relevant development standards.
2. Follow the approved implementation plan.
3. For Power Automate cloud flow changes:

   * Use the available Power Automate skills (`create-flow`, `build-flow`, `debug-flow`, `manage-flows`) and FlowAgent MCP tools.
   * Use `src/flows/` as the project-standard location for local flow definition exports.
   * Ensure the current flow definition is retrieved from the target environment (`get_flow`) before making implementation changes.
   * Do not treat exported flow JSON as an ordinary text source file to hand-edit and re-upload wholesale; prefer `edit_flow` (surgical operations) or `update_flow` (full definition) via FlowAgent MCP.
   * Run `preflight_flow` / `validate_flow` before creating or updating a flow where available.
   * If the required FlowAgent MCP tools or synchronization are unavailable, report the limitation and do not make flow implementation changes.
4. Make the smallest necessary change required by the approved plan.

After implementation:

1. Validate the implementation against the relevant requirements and development standards.
2. Use the validation capabilities provided by FlowAgent MCP, including `preflight_flow`/`validate_flow` and a test run (`run_flow` for instant/HTTP-triggered flows, or `get_past_trigger_inputs` + `resubmit_run` for event-triggered flows).
3. Run any other available checks relevant to the change (e.g. `diagnose_run` on the resulting run).
4. Confirm that the local export under `src/flows/` represents the resulting Power Platform state.
5. Report any deviation from the approved plan or development standards.
