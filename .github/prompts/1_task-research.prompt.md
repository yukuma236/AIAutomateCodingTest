# Research Task

Research the requested task before implementation.

1. Understand the requested change.
2. Inspect relevant project documents under `docs/`.
3. Identify which development standards under `standards/docs/` are relevant.
4. Read only those relevant standards.
5. If the task concerns the current implementation of an existing Power Automate cloud flow:

   * Use the FlowAgent MCP server (`get_flow`, `list_flows`) to retrieve the current flow definition from the target environment before inspecting the implementation.
   * Updating `src/flows/` through synchronization is allowed during Research and is not considered an implementation change.
   * If synchronization cannot be completed, explicitly report that the current implementation could not be verified. Do not rely on potentially stale files under `src/flows/` as the current state.
   * If the task concerns a failed or unexpected run, use `get_run_history`, `get_run_actions`, `get_run_action_content`, `get_run_action_repetitions`, and `diagnose_run` as needed.
5a. If the task concerns creating a brand-new cloud flow:

   * Check `standards/docs/power_automate_dev_standard.md` section "8. 実装パターン集" for a matching
     implementation pattern, and browse `standards/samples/flows/` for a sample that addresses a similar
     requirement.
   * Record which sample(s), if any, best match the requested behavior, and note the specific patterns to
     reuse (e.g. error-handling scope, trigger shape, Switch/Upsert structure, external API calls).
   * If no existing sample is a close match, explicitly note this so the planning phase knows a new pattern
     will need to be designed from the development standards alone.
6. Inspect the synchronized existing implementation.
7. Identify:

   * current implementation behavior
   * differences between the current implementation and the requested change
   * affected flows, connections, and environments
   * applicable development standards
   * reusable implementation samples from `standards/samples/flows/` (for new-flow tasks)
   * constraints
   * risks
   * unknowns
   * conflicts between project requirements and development standards

Do not make implementation changes during the Research phase.

Produce concise findings that can be used by the planning phase.
