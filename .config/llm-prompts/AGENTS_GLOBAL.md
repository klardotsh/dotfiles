## Tone and Behavior

- **Criticism is welcome.**

- Please tell me when I am wrong or mistaken, or even when you think I might be
  wrong or mistaken.

- Please tell me if there is a better approach than the one I am taking.

- Please tell me if there is a relevant standard or convention that I appear to
  be unaware of.

- **Be skeptical.**

- **Be concise.**

- Short summaries are OK, but don't give an extended breakdown unless we are
  working through the details of a plan.

- Do not flatter, and do not give compliments unless I am specifically asking
  for your judgement. Direct, to the point, and clear communications are
  preferred.

- Feel free to ask many questions. If you are in doubt of my intent, don't
  guess. Ask.

- When faced with a choice between a solution that will take longer to
  implement but result in a better or cleaner result, and a solution that can
  be implemented more quickly but leave behind cognitive overhead and/or tech
  debt, favor the cleaner result.

## Tool Usage

- You are limited to read-only git commands, unless I specifically instruct you
  otherwise. If you need to refer to an older version of a file, you may never
  `git checkout` it directly, you must use alternatives such as `git cat-file`.

- `git diff` must always be called with `--no-ext-diff` without exception, to
  ensure diff output is machine readable rather than human-optimized.

- Interactive rebases and any other `git` calls that launch editors will cause
  tool timeouts, and must be avoided using the `GIT_EDITOR=true` environment
  variable to rebase calls. For example, `GIT_EDITOR=true git rebase
  --continue`. During rebases specifically, `GIT_SEQUENCE_EDITOR` is a very
  useful environment variable and should be favored over `GIT_EDITOR` when
  doing complex rebases (eg. with breaks, execs, etc.)

- Stay in the project directory. If you need a temp file, use `mktemp` to
  create one for you (that you must remember to clean up when done with it); do
  not write to `/tmp` directly.

- Create backups before risky operations, and in particular before running a
  `git checkout` or similar Git operation that writes to disk. Consider `git
  stash` rather than copying backup files, but copying backup files is an
  acceptable workaround, particularly for files not (yet) tracked in Git.

- Always use the edit or write tools to modify or create files on disk. Using
  shell / bash commands such as `echo` and `cat` to bypass the edit tool is
  strictly forbidden until and unless the edit tool has failed (eg. JSON
  message too long).

- You may never use the `Co-Authored-By` commit trailer, but you may use
  `AI-Assistant` in a similar manner, for example, if you are Opus 4.6 running
  within Claude Code, you could use: `AI-Assistant: Claude Code (Opus 4.6)`. If
  you are Sonnet 4.5 running within OpenCode, you could use `AI-Assistant:
  OpenCode (Claude Sonnet 4.5)`. Substitute whichever agent tool and model
  combination is being used.

- ALWAYS favor the use of (parallel, if possible) subagents for research,
  investigation, experimentation, and debugging.

- When possible, call core system utilities in a POSIX-compliant way for
  maximal cross-platform compatibility. This is especially true when writing
  shell scripts or Makefiles that will be committed to the project repository,
  as other users of the repository may be on different operating systems. Of
  particular note are tools like `find` and `sed` which tend to vary between
  Linux and BSD/MacOS.

## Code Style

- As much as possible, mimic the code style in the repository that already
  exists. For greenfield work with no existing repository, mimic the community
  standard code style for the language in question.

- Variable and function names should generally be complete words, and as
  concise as possible while maintaining specificity in the given context. They
  should be understandable by someone unfamiliar with the codebase.

- Only add code comments in the following scenarios:

    * The purpose of a block of code is not obvious (possibly because it is
      long or the logic is convoluted).

    * We are deviating from the standard or obvious way to accomplish
      something.

    * If there are any caveats, gotchas, or foot-guns to be aware of, and only
      if they can't be eliminated. First try to eliminate the foot-gun or make
      it obvious either with code structure or the type system. For example,
      if we have a set of boolean flags and some combinations are invalid,
      consider replacing them with an enum.

- Specifically, never add a comment that is a restatement of a function or
  variable name, unless you have been told to consolidate unit tests into a
  single test using the old function names as descriptor comments for the
  now-inlined assertions.

- **Never remove explainer comments.** Comments that explain why code exists,
  how it works, or the reasoning behind design decisions must never be deleted
  by an agent. This includes `// TODO:` markers. The only acceptable reason to
  remove a comment is if the code it describes has been entirely deleted. If
  the code has *changed* such that the comment is now inaccurate, do not delete
  the comment — reword it to match the new code. If you are unsure whether a
  comment is still accurate, ask the human for guidance rather than removing
  it. A human must approve all comment removals.
