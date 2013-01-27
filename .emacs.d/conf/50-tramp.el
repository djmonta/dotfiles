;;-----------------------------------------------------------------
;; Tramp
;;-----------------------------------------------------------------
(require 'tramp)
(setq tramp-default-method "ssh")

;;省略ネーム
;(setenv "X" "/ssh:monta@192.168.0.4:")
;(setenv "XS" "/ssh:monta@192.168.0.4:sudo:root@localhost:")
;;C-x C-f $X/path/to/file RET.

(add-to-list 'tramp-default-proxies-alist
	     '("landiskgxr" "root" "/ssh:monta@192.168.0.4:")
	     '("raspberrypi" "root" "/ssh:monta@192.168.0.5"))


;;/etc/hosts : 普通に /etc/hosts を開く。Read Only
;;/sudo::/etc/hosts : root で /etc/hosts を開く。
;;/host.computer:/etc/hosts : 普通にホスト の /etc/hosts を開く。Read Only
;;/sudo:host.computer:/etc/hosts : root でホスト の /etc/hosts を開く。

 (defun file-other-p (filename)
  "Return t if file FILENAME created by others."
  (if (file-exists-p filename)
      (/= (user-real-uid) (nth 2 (file-attributes filename))) t))

(defun file-username (filename)
   "Return File Owner."
   (if (file-exists-p filename)
      (user-full-name (nth 2 (file-attributes filename)))
     (user-full-name (nth 2 (file-attributes (file-name-directory filename))))))

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (file-other-p (ad-get-arg 0))
           (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0) " is "
                             (if (file-exists-p (ad-get-arg 0)) "read-only." "newer file.")
                             "  Open it as "
                                     (file-username (ad-get-arg 0)) "? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
    (set-buffer (find-file (concat "/sudo:"
                                   (file-username file) "@" (system-name) ":" file))))
