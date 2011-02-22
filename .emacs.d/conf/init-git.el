(require 'egg)
(add-to-list 'exec-path "/usr/local/bin")

(require 'git-emacs)
(fmakunbound 'git-status)   ; Possibly remove Debian's autoloaded version
(require 'git-emacs-autoloads)
(add-to-list 'vc-handled-backends 'GIT)
(autoload 'git-status "git" "Entry point into git-status mode." t)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(require 'git)
