# Implement Task

Implement and validate only the explicitly approved plan.

## Entry conditions

1. Read the approved Research handoff, approved business specifications, approved Plan, and applicable Test Specification/Test Case from the repository or current conversation. Do not rely on chat history that was not handed over.
2. If approval is missing, required artifacts are unavailable, or an implementation detail would change approved business behavior, stop implementation and return the issue to Research or Plan for resolution and approval.
3. Reconfirm project requirements and only the relevant shared standards through `standards/docs/README.md`. If present in the submodule, explicitly read `standards/.github/copilot-instructions.md`.

## Implement and validate

* Make the smallest change that fulfills the approved plan. Do not widen scope or reinterpret business behavior.
* For Power Automate cloud flow changes, use the available Power Automate skills and FlowAgent MCP tools. Retrieve the current definition again with `get_flow` before changing an existing flow. Do not hand-edit and upload an exported JSON as an ordinary text file; use `edit_flow` for surgical changes or `update_flow` when a full definition is appropriate.
* Use `src/flows/` for local exports. Run `preflight_flow`/`validate_flow` where available before creation or update. If the required tools or synchronization are unavailable, report that limitation and do not make flow changes.
* Prefer Developer or Sandbox. Do not use Production without explicit authorization and a documented justification.
* Validate every approved Test Case against its approved expected result. Use `run_flow` for instant/HTTP-triggered flows or `get_past_trigger_inputs` and `resubmit_run` for event-triggered flows as appropriate; use `get_run_actions`, `get_run_action_content`, and `diagnose_run` to verify the results.
* Do not derive or alter expected results from the implemented flow's observed behavior. Report mismatches as failures and request a specification decision rather than silently changing the expected result.
* Record evidence per Test Specification and Case, including pass/fail, actual result, and the full Run URL. Confirm that `src/flows/` is synchronized with the resulting Power Platform definition.
* If validation requires a business-specification change, stop and return to Research; if the technical approach or scope must change, return to Plan and obtain approval before continuing.

## Completion handoff

Report changes, target environment, validation results by case, evidence locations/Run URLs, synchronization status, and any deviations or blockers. Keep the approved specifications and plan as the durable source of truth for a later chat.
