;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mac 用設定

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)

;;ATOK2012
(setq default-input-method "MacOSX")
(mac-set-input-method-parameter "com.justsystems.inputmethod.atok25.Japanese" `title "漢")
(mac-set-input-method-parameter "com.justsystems.inputmethod.atok25.Japanese" `cursor-type 'box)
(mac-set-input-method-parameter "com.justsystems.inputmethod.atok25.Japanese" `cursor-color "magenta")