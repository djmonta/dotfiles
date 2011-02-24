;; clmemo
;; http://web.archive.org/web/20080118171036/pop-club.hp.infoseek.co.jp/emacs/clmemo.html
(autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
;(define-key ctl-x-map "M" 'clmemo)
(global-set-key "\C-xM" 'clmemo)
(setq clmemo-file-name "~/Dropbox/PlainText/ChangeLog.txt")
;(setq clmemo-entry-list
;      '("emacs" "book" "url" "idea" "download" "soft" "memo"))
(setq clmemo-time-string-with-weekday t)
(setq clmemo-subtitle-char "["
      clmemo-subtitle-punctuation-char '( "[" . "]"))

;; clgrep
(autoload 'clgrep "clgrep" "grep mode for ChangeLog file." t)
(autoload 'clgrep-title "clgrep" "grep first line of entry in ChangeLog." t)
(autoload 'clgrep-header "clgrep" "grep header line of ChangeLog." t)
(autoload 'clgrep-other-window "clgrep" "clgrep in other window." t)
(autoload 'clgrep-clmemo "clgrep" "clgrep directly ChangeLog MEMO." t)
(add-hook 'change-log-mode-hook
          '(lambda ()
             (define-key change-log-mode-map "\C-c\C-g" 'clgrep)
             (define-key change-log-mode-map "\C-c\C-t" 'clgrep-title)))

(provide 'init-clmemo)