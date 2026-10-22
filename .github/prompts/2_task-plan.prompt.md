# Plan Task

Create an implementation plan from the approved Research handoff and its durable project documents.

## Entry conditions

1. Confirm that the Research handoff and the business requirements/processing specifications it cites are available in this conversation or by explicit repository paths. Do not rely on an earlier chat's unshared context.
2. Confirm explicit approval of the business behavior that the plan will implement. If a material decision is unresolved or approval is absent, return to Research and do not plan around an assumption.
3. Read project-specific requirements and only the relevant shared standards through `standards/docs/README.md`. If present in the submodule, explicitly read `standards/.github/copilot-instructions.md`; do not assume it is automatically applied.
4. Identify affected flows, connections/connection references, environment variables, external systems, and target environment. For new flows, include any matching implementation samples identified during Research.

## Required plan contents

State:

* approved requirements and specification references, scope, exclusions, and why each change is needed
* target flow(s), trigger and business-level inputs/outputs, including notification, response, and failure outputs where applicable
* proposed flow structure and technical approach, including connection references, environment variables, error handling (Try/Catch/Finally where applicable), and relevant concurrency or retry behavior
* traceability from approved requirements/features/data flows to planned implementation and each Test Specification/Test Case
* applicable standards and sample patterns, plus any conflicts or deviations requiring approval
* target environment (prefer Developer or Sandbox; Production requires explicit authorization and justification)
* validation by approved test cases, expected results sourced from approved specifications, FlowAgent preflight/validation, and run evidence to retain
* risks, dependencies, rollback/cleanup considerations, and implementation blockers

Do not add business behavior or expected results that are not in the approved requirements. If technical design requires a decision that could alter business behavior, return to Research. Mark any non-business technical assumption clearly and obtain approval when it changes scope, risk, or environment.

End with a clear approval gate: do not implement until the user explicitly approves this plan. Save the approved plan in the repository and name its path in the handoff so it can be passed to a separate implementation chat.
