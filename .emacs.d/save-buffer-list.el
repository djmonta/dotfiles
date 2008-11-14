;;; 
;;; [buffer-list$BFI$_9~$_4X?t(B]
;;; save-current-buffer-list$B$G8=:_$N(Bbuffer-list$B$r(B~/.bufferlist$B$K(B
;;; $BJ]B8$7$^$9!#(B
;;; load-buffer-list$B$G(B~/.bufferlist$B$K5-=R$5$l$?%U%!%$%k$r%P%C%U%!$K(B
;;; $BFI$_9~$_$^$9!#(B
;;; 
;;; TODO: $B=EJ#%U%!%$%k$N=hM}(B
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

