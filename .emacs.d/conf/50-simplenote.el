; http://blog.serverworks.co.jp/tech/2010/06/30/emacs-iphone-simplenote-and-vuvuzela/
(require 'simplenote)

(defvar simplenote-email)
(defvar simplenote-password)

(defun my-simplenote-setup ()
  (setq auth
        (json-read-from-string
         (shell-command-to-string
          "pit get simplenoteapp.com | ruby -ryaml -rjson -e 'puts YAML.load($<).to_json'" )))
  (setq simplenote-email (cdr (assoc 'email auth)))
  (setq simplenote-password (cdr (assoc 'password auth))))

(if (executable-find "pit")
    (progn
      (my-simplenote-setup)
      (simplenote-setup))
  (message "pit: command not found"))

; https://gist.github.com/458545
(defadvice simplenote-open-note (after my-simplenote-open-note activate)
  "automatically call simplenote-sync-notes after save"
  (add-hook 'after-save-hook
            (lambda () (save-excursion
                         (simplenote-sync-notes)
                         (simplenote-browser-refresh)))
            nil t)) ; add hook only locally (forth argument)

;; key
; (define-key ctl-q-map (kbd "C-s") 'simplenote-browse)

