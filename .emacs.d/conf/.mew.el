;; 未読にマーク
(setq mew-delete-unread-mark-by-mark nil)

;; SSL
(setq mew-ssl-verify-level 0)
(setq mew-prog-ssl "/usr/local/bin/stunnel")

;; スレッド
(setq mew-use-fancy-thread t)

;; パスワードキャッシュ
(setq mew-use-cached-passwd t)

;; Summaryモードの書式
(setq mew-summary-form
   '(type (5 date) " "  (5 time) " " (20 from) " " t (0 subj)))
;(setq mew-summary-form-body-starter nil)

;; HTMLメール
(condition-case nil
  (require 'mew-w3m)
  (file-error nil))
(setq w3m-type 'w3m)
(require 'mew-w3m)
(setq mew-prog-html '(mew-mime-text/html-w3m nil nil))

;; 基本設定
(setq mew-name "Sachiko Miyamoto")
(setq mew-proto "%")
(setq mew-smtp-server "smtp.gmail.com")
(setq mew-config-alist
  '(;; config alist
    ("gmail"
      ("user"                . "sachiko.miyamoto")
      ("mail-domain" . "gmail.com")
      ("imap-server"     . "imap.gmail.com")
      ("imap-user"       . "sachiko.miyamoto@gmail.com")
      ("imap-auth"       . t)
      ("imap-ssl"        . t)
      ("imap-ssl-port"   . "993")
      ("imap-delete"     . nil)
      ("imap-size"       . 0)
    )
))