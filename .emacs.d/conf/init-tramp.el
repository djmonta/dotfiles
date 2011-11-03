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
			 '("192.168.0.4" "root" "/ssh:monta@192.168.0.4:"))
(add-to-list 'tramp-default-proxies-alist
			 '("amz-as.in" "root" "/ssh:monta@amz-as.in:"))
;;/etc/hosts : 普通に /etc/hosts を開く。Read Only
;;/sudo::/etc/hosts : root で /etc/hosts を開く。
;;/host.computer:/etc/hosts : 普通にホスト の /etc/hosts を開く。Read Only
;;/sudo:host.computer:/etc/hosts : root でホスト の /etc/hosts を開く。

(provide 'init-tramp)