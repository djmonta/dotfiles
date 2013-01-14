;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Linux用設定

;;Mule-UCS UTF-8
;(require 'un-define)
(setq bitmap-alterable-charset 'tibetan-1-column)
;(require 'jisx0213)

;; タイムスタンプ
(if (not (memq 'time-stamp write-file-functions))
    (setq write-file-functions
    (cons 'time-stamp write-file-functions)))
