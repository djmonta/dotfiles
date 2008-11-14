;;; 
;;; [buffer-list読み込み関数]
;;; save-current-buffer-listで現在のbuffer-listを~/.bufferlistに
;;; 保存します。
;;; load-buffer-listで~/.bufferlistに記述されたファイルをバッファに
;;; 読み込みます。
;;; 
;;; TODO: 重複ファイルの処理
;;; 
;;; R. Suetsugu
;;; 

(defun save-current-buffer-list ()
  (interactive)
  (save-excursion
    (let ((cur-buf (current-buffer))
	  (tmp-buf (generate-new-buffer "*tmp-buffer*")))
      (switch-to-buffer tmp-buf)
      (dolist (buffer (buffer-list))
	(if (buffer-file-name buffer) 
	    (insert (abbreviate-file-name (buffer-file-name buffer)) "\n")
	  t))
      (kill-buffer (write-file "~/.bufferlist"))
      (switch-to-buffer cur-buf))))

(defun load-buffer-list ()
  (interactive)
  (let ((cur-buf (current-buffer))
	(list-buf (find-file "~/.bufferlist"))
	(line 1))
    (while (not (equal "" (setq b (buffer-substring (point-at-bol) (point-at-eol)))))
      (find-file-noselect b)
      (goto-line (setq line (+ line 1))))
    (switch-to-buffer cur-buf)
    ))

