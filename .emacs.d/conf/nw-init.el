;;Emacs (Terminal) 用設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;EmacsServer --バイブル P.91
;;Usage
;; emacs --daemon
;; emacsclient FILENAME

;(server-start)
(add-hook 'after-init-hook 'server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))

;編集が終了したらEmacsをアイコン化する
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)

;C-x C-c に割り当てる
(global-set-key (kbd "C-x C-c") 'server-edit)

;M-x exitでEmacsを終了できるようにする
(defalias 'exit 'save-buffers-kill-emacs)

;コミットメッセージを日本語で！
;; git commit したときのバッファを utf-8 にする
(add-hook 'server-visit-hook
  (function (lambda ()
     (if (string-match "COMMIT_EDITMSG" buffer-file-name)
         (set-buffer-file-coding-system 'utf-8)))))

(global-font-lock-mode t)  ;文字装飾(カラー強調)
(setq-default transient-mark-mode t) ;リージョンのハイライト
;(tool-bar-mode nil) ;M-x tool-bar-mode で表示非表示を切り替え
(menu-bar-mode nil) ;メニューバー非表示

