#!/usr/bin/env bash

# https://github.com/dom96/choosenim/blob/master/analytics.md
export DO_NOT_TRACK=1

# We always use Copilot Proxy for OpenAI API calls
export OPENAI_API_BASE='http://localhost:8923'
export OPENAI_BASE_URL="${OPENAI_API_BASE}"

# LLM Prompts
export LLM_COMMIT_PROMPT='
Generate ONE commit message based on Conventional Commits specification with a review comment below, without any markers or wrappers for the text.

# Commit Summary
Make sure to never exceed the 50 characters hard limit at commit summary.
## Types
- **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **ci**: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs, GitHub Actions)
- **docs**: Documentation only changes
- **feat**: A new feature
- **fix**: A bug fix
- **perf**: A code change that improves performance
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: Adding missing tests or correcting existing tests

## Scope
Generally the module path or name of the affected files or responsibilities, simplified if needed to fit the summary word limit.

- Good Examples:
  - test(platform/shotgun): fix address test
  - wip(platform/shotgun): fix tests
  - test(platform/sympla): fix channel tests
  - fix(platform/sympla,shotgun): log context
  - fix(manager): disable shotgun
  - ci(github): workflow dispatch on PR
  - fix(platform/shotgun): close channel
  - fix(platform/shotgun,sympla): test goroutine
  - fix(platform/shotgun): tests
  - test(platform/shotgun): service and entry point
  - wip(platform/shotgun): test service
  - chore(mod): bump api to v0.0.3

  Bad examples with their correct below:
  - chore: update docs
    - docs(readme): missign flag at usage
  - feat: add TODOs, configure SaoPauloStr to be sent to Sympla endpoint
    - refactor(platform/sympla): SaoPauloStr declaration
  - feat: add metrics instrumentation
    - feat(handlers/event): success and error metrics
  - feat: add minimum version to Go
    - chore(mod): go minimum version
  - feat: add new items to doc
    - docs(readme): add new items on FAQ
  - feat: add docs
    - docs: readme
  - feat: cron sympla with all features enabled
    - feat(platforms/sympla): all features
  - feat: add image build
    - chore(makefile): add docker image build command
  - Initial commit
    - chore: scaffold with create-react-app

# Commit Description
The description is a quick description describing the overall intention followed by a bullet list detailing the changes carefully.

- Good examples:
  ```
  Fix Match card address formatting and tests
  - Updated the filter function at Match card component to exclude strings containing only non-alphanumeric characters at `formatEventAddress` helper function.
  - Updated the Match card component test case to cover the changes on the `formatEventAddress`
  ```
  Why? Each change in a different bullet point, explanations are quick and relevant.
- Bad example:
  ```
  - Updated the filter function to exclude strings containing only non-alphanumeric characters, ensuring better address formatting. And updated the tests to cover that change, ensuring the tests passing.
  ```
  Why? Missing quick description, one liner, empty explanations and hard to read.

# Critical Review
Provide a bullet list with critical key points about the diff. Omit when not needed.

# Overall Commit Message Structure
The commit message should be structured as follows:

    <type>[scope(s)]: <description>

    [body]

    ---

    Critical Review:
    [critical review]

# Edge Cases
- If multiple intentions and scopes are present, use the most relevant one in the summary and but include all in the body.
'

export AIDER_COMMIT_PROMPT="${LLM_COMMIT_PROMPT}"
