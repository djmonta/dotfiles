;;; blgrep.el --- Block grep -*-emacs-lisp-*-

;; Copyright (C) 2004 Masayuki Ataka <ataka@milk.freemail.ne.jp>

;; Author: Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; Keywords: tools, convenience

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; Code:
(provide 'blgrep)

;;
;; User Options.
;;
(defvar blgrep-highlight-match-string (fboundp 'overlay-put)
  "*If non-nil, highlight matched text in blgrep buffer.")

(defvar blgrep-buffer-name-alias-alist nil
  "*Alist of aliases for buffer name in modeline.
Each element looks like (ALISES . BUFFER-FILE-NAME).")

(defvar blgrep-boundary "^"
  "*Regexp for boundary of text that blgrep target.
blgrep does not scan the text after the boundary.

If multiple boundaris are in the text, blgrep regards the last
regexp as the boundary.  You can write file variable or something
after it.")

;;
;; System Variables
;;
(defvar blgrep-buffer-file-name nil)
(defvar blgrep-buffer-file-name-tmp nil)
(defvar blgrep-file-local-variable nil)

;;
;; Font-Lock
;;
(defface blgrep-highlight-match-face nil
  "Face for highlighting the match text in blgrep buffer.")

(defvar blgrep-highlight-match-face 'blgrep-highlight-match-face)

(if (boundp 'isearch-lazy-highlight-face)
    (copy-face 'isearch-lazy-highlight-face 'blgrep-highlight-match-face)
  (copy-face 'secondary-selection 'blgrep-highlight-match-face))

;;
;; blgrep code
;;
(defun blgrep (query rev mode &optional blgrep-type blank-num)
  (or (stringp blgrep-type) (setq blgrep-type "blgrep"))
  (or (numberp blank-num) (setq blank-num 0))
  (if (equal query "")
      (blgrep-quasi-viewer blgrep-type)
    (let (scan-result)
      (save-excursion
	(save-restriction
	  ;; Preparation
	  (blgrep-save-file-local-variable)
	  (blgrep-narrow)
	  ;; Scan
	  (goto-char (point-max))
	  (setq scan-result (blgrep-scan query blank-num))))
      (if (not scan-result)
	  (unwind-protect
	      (error "No matches for `%s'" query)
	    (setq blgrep-file-local-variable nil))
	(let ((count (car scan-result))
	      (block-tree (cdr scan-result)))
	  (message "%d matched" count)
	  ;; Print
	  (blgrep-print block-tree rev blgrep-type)
	  (blgrep-highlight-match query)))))
  (funcall mode)
  (blgrep-set-local-variable))

(defun blgrep-scan (query blank-num)
  ;; Point is at the end of buffer or near the boundary.
  ;; Scan starts not from beginning of buffer!
  (let ((case-fold-search (and case-fold-search
                               (isearch-no-upper-case-p query t)))
	(blank (make-string blank-num ?\n))
	(count 0) pos beg end tree sub-tree heading)
    (while (setq pos (re-search-backward query nil t))
      (when (blgrep-target-p)
	;; Copy body
	(setq end (save-excursion (blgrep-end-of-block) (point)))
	(setq beg (progn (blgrep-beg-of-block) (point)))
	(when (and (>= pos beg) (<= pos end))
	  (setq sub-tree (buffer-substring-no-properties beg end)
		count (1+ count))
	  (setq beg (string-match "\n" sub-tree)) ;reuse BEG (bad manner?)
	  (if beg
	      (setq sub-tree (list (concat blank (substring sub-tree 0 (1+ beg)))
				   (list (concat (substring sub-tree (1+ beg)) "\n"))))
	    (setq sub-tree (list (concat blank sub-tree "\n"))))
	  ;; Copy headings
	  (save-excursion
	    (while (not (blgrep-top-p))
	      (setq heading (concat blank
				    (buffer-substring-no-properties
				     (progn (blgrep-up-block) (beginning-of-line) (point)) ;beg
				     (save-excursion (forward-line 1) (point)))) ;end
		    sub-tree (list heading sub-tree))))
	  ;; Construct block tree
	  (setq tree (blgrep-cons-tree tree sub-tree)))))
    (when (> count 0)
      (cons count tree))))

(defsubst blgrep-equal-car (o1 o2)
  (equal (car o1) (car o2)))
(defsubst blgrep-cdr-check (o1 o2)
  (or (cdr o2) (consp (cadr o1))))

(defun blgrep-cons-tree (tree sub-tree)
  "Construct tree from TREE and SUB-TREE."
  (if (and (blgrep-equal-car tree sub-tree)
	   (blgrep-cdr-check tree sub-tree))
      (apply 'list (car tree) (blgrep-cons-tree (cadr tree) (cadr sub-tree)) (cddr tree))
    (append sub-tree tree)))

;;; Bug Check
;;
;; (blgrep-cons-tree '("* FOO" ("bar"))         '("* FOO" ("foo")))
;; (blgrep-cons-tree '("* FOO" ("foo" ("bar"))) '("* FOO" ("foo")))
;; (blgrep-cons-tree '("* FOO" ("foo"))         '("* FOO" ("foo")))
;; (blgrep-cons-tree '("* FOO" ("foo" "bar"))   '("* FOO" ("foo")))
;; (blgrep-cons-tree '("* FOO" ("bar") "* BAR") '("* FOO" ("foo")))
;;
;;   => ("* FOO" ("foo" "bar"))
;;   => ("* FOO" ("foo" ("bar")))
;;   => ("* FOO" ("foo" "foo"))
;;   => ("* FOO" ("foo" "foo" "bar"))
;;   => ("* FOO" ("foo" "bar") "* BAR")
;;

(defun blgrep-print (tree rev blgrep-type)
  "Switch to blgrep buffer and print TREE."
  ;; preparation
  (blgrep-switch-to-buffer blgrep-type)
  ;; print tree
  (if (not rev)
      (insert (blgrep-concat-tree tree))
    (while tree
      (insert (nth 0 tree))
      (insert (blgrep-concat-tree (nth 1 tree)))
      (setq tree (nthcdr 2 tree))
      (goto-char (point-min))))
  ;; after treatment
  (goto-char (point-min))
  (when (looking-at "\n+")
    (replace-match ""))
  (setq buffer-read-only t)
  (set-buffer-modified-p nil))

(defun blgrep-concat-tree (node)
  "Concat NODE"
  (if (atom node)
      node
    (mapconcat (lambda (sub-node) (blgrep-concat-tree sub-node)) node "")))

(defun blgrep-narrow ()
  "Narrow the text for blgrep.
The text is narrowed between the point that function `blgrep-point-min' returns
and the variable `blgrep-boundary'.
If mark is active, narrow the region, instead."
  (if (blgrep-region-exists-p)
      (narrow-to-region (region-beginning) (region-end))
    (let (beg end)
      (goto-char (point-min))
      (setq beg (blgrep-point-min))
      (blgrep-search-boundary)
      (setq end (point))
      (narrow-to-region beg end))))

(defun blgrep-quasi-viewer (blgrep-type)
  (unless blgrep-buffer-file-name
    (let ((pos (point))
	  (buf (current-buffer)))
      (blgrep-save-file-local-variable)
      (blgrep-switch-to-buffer blgrep-type)
      (insert-buffer-substring buf)
      (when blgrep-file-local-variable
	(blgrep-search-boundary)
	(delete-region (point) (point-max)))
      (setq buffer-read-only t)
      (set-buffer-modified-p nil)
      (goto-char pos))))

(defun blgrep-switch-to-buffer (blgrep-type)
  (let* ((buf-file-name (or blgrep-buffer-file-name (buffer-file-name) (buffer-name)))
	 (alias (car (delq nil (mapcar (lambda (cons-cell)
					 (if (equal buf-file-name
						    (expand-file-name (cdr cons-cell)))
					     (car cons-cell)))
				       blgrep-buffer-name-alias-alist))))
	 (bufname (format "*%s: %s*" blgrep-type
			  (or alias (abbreviate-file-name buf-file-name))))
	 (blwin (get-buffer-window bufname)))
    (if blwin
	(select-window blwin)
      (switch-to-buffer bufname))
    (setq blgrep-buffer-file-name-tmp buf-file-name))
  (setq buffer-read-only nil)
  (erase-buffer)
  (goto-char (point-min)))

(defun blgrep-highlight-match (search)
  "Highlight match string.
Variable `blgrep-highlight-match-string' controls highlight or not.
`blgrep-highlight-match-face' is used for highlight face."
  (when blgrep-highlight-match-string
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward search nil t)
	(let ((mb (match-beginning 0))
	      (me (match-end 0)))
	  (if (= mb me)			;zero-length match
	      (forward-char 1)

	    ;; non-zero-length match
	    (let ((ov (make-overlay mb me)))
	      (overlay-put ov 'face blgrep-highlight-match-face)
	      (overlay-put ov 'prioryty 0) ;lower than main overlay
	      (overlay-put ov 'window (selected-window)))))))))

(defun blgrep-region-exists-p ()
  "Return t if mark is active."
  (cond
   ((boundp 'mark-active) mark-active)		  ;For Emacs
   ((fboundp 'region-exists-p) (region-exists-p)) ;For XEmacs
   (t (error "No funcntion for checking region"))))

(defun blgrep-search-boundary ()
  "Return non-nil if succeed in searching `blgrep-boundary'.
Set point to the last `blgrep-boundary' if succeed,
or end of buffer if not."
  (goto-char (point-max))
  (and blgrep-boundary
       (re-search-backward blgrep-boundary nil t)))

;;
;; Inherite File Local Variable
;;
(defun blgrep-save-file-local-variable ()
  (save-excursion
    (save-restriction
      (widen)
      ;; Look for "Local Variables:" line in last page.
      ;; Copied from file.el in Emacs 21.3.50
      (goto-char (point-max))
      (search-backward "\n\^L" (max (- (point-max) 3000) (point-min)) 'move)

      (let ((case-fold-search t))
	(when (search-forward "Local Variables:" nil t)
	  (let ((beg (progn (beginning-of-line) (point))))
	    (when (search-forward "End:" nil t)
	      (end-of-line)
	      (unless (eobp)
		(forward-line 1))
	      (setq blgrep-file-local-variable
		    (buffer-substring-no-properties beg (point))))))))))

(defun blgrep-inherite-file-local-variable ()
  (when blgrep-file-local-variable
    (with-temp-buffer
      (insert blgrep-file-local-variable)
      (goto-char (point-min))
      (while (re-search-forward "[^-A-z]mode:" nil t)
	(beginning-of-line)
	(delete-region (point) (progn (forward-line 1) (point))))
      (setq blgrep-file-local-variable (buffer-substring (point-min) (point-max))))
    (let ((buffer-read-only nil))
      (save-excursion
	(goto-char (point-max))
	(unless (progn (skip-chars-backward " \t\n")
		       (eq (char-before) ?))
	  (insert "\n\n\n"))
	(insert blgrep-file-local-variable))
      (setq blgrep-file-local-variable nil)
      (set-buffer-modified-p nil)))
  (hack-local-variables))


;;
;; blgrep grep -- demo funciton
;;
;;;;
;;
;; (defun blgrep-grep (query rev)
;;   "Not good implementation of function occur."
;;   (interactive "sQuery: \nP")
;;   (blgrep query rev)
;;   (blgrep-mode))
;;

;;
;; Virtual functions for blgrep
;;

(defun blgrep-point-min ()
  (point))

(defun blgrep-beg-of-block ()
  (beginning-of-line))

(defun blgrep-end-of-block ()
  (end-of-line))

(defun blgrep-up-block ()
  t)

(defun blgrep-target-p ()
  t)

(defun blgrep-top-p ()
  t)

;;
;; Templete of blgrep-mode
;;

(defvar blgrep-mode-map nil)
(if blgrep-mode-map
    nil
  (let ((map (make-keymap)))
    (suppress-keymap map)
    ;; common functions
    (define-key map "q" 'blgrep-quit)
    (define-key map "R" 'blgrep-regrep)
    (define-key map "\C-m" 'blgrep-jump)
    (define-key map "\C-x4\C-m" 'blgrep-jump-other-window)
    (define-key map "\C-x5\C-m" 'blgrep-jump-other-frame)
    ;; common dummy functions
    (define-key map "g" 'blgrep-dummy)
    (define-key map "n" 'blgrep-next)
    (define-key map "p" 'blgrep-previous)
    (define-key map "f" 'blgrep-forward)
    (define-key map "b" 'blgrep-backward)
    ;; movement functions
    (define-key map "s" 'isearch-forward)
    (define-key map "r" 'isearch-backward)
    (define-key map "<" 'beginning-of-buffer)
    (define-key map ">" 'end-of-buffer)
    (define-key map " " 'scroll-up)
    (define-key map [backspace] 'scroll-down)
    (define-key map "a" 'beginning-of-line)
    (define-key map "e" 'end-of-line)
    (define-key map "l" 'recenter)
    ;; misc commands
    (define-key map "." 'set-mark-command)
    (define-key map "h" 'mark-paragraph)
    (define-key map "," 'pop-to-mark-command)
    (define-key map "m" 'point-to-register)
    (define-key map "'" 'register-to-point)
    (define-key map "x" 'exchange-point-and-mark)
    (setq blgrep-mode-map map)))

(define-derived-mode blgrep-mode text-mode "blgrep"
  "Major mode for blgrep.")

(defun blgrep-set-local-variable ()
  (set (make-local-variable 'blgrep-buffer-file-name) blgrep-buffer-file-name-tmp)
  (blgrep-inherite-file-local-variable))

;;
;; blgrep common functions
;;

(defun blgrep-quit ()
  "Quit blgrep."
  (interactive)
  (quit-window))

(defun blgrep-jump-other-window ()
  "Jump to the source at point in other window."
  (interactive)
  (blgrep-jump 'window))

(defun blgrep-jump-other-frame ()
  "Jump to the source at point in other frame."
  (interactive)
  (blgrep-jump 'frame))

(defun blgrep-jump (&optional win-frame)
  "Jump to the source at point."
  (interactive)
  (let (search-text (pos (point)))
    ;; To get search-text.
    (save-excursion
      (let ((end (progn (end-of-line) (skip-syntax-backward "->") (point))) ;eat blank lines
	    (beg (progn (beginning-of-line) (point))))
	(setq search-text (buffer-substring-no-properties beg end)
	      pos (- end pos))))
    ;; Jump to search-text.
    (blgrep-goto-source-at-point search-text pos t win-frame)))

(defun blgrep-goto-source-at-point (text-list &optional pos bol win-frame)
  (let ((buf (or (get-file-buffer blgrep-buffer-file-name)
		 (get-buffer blgrep-buffer-file-name)
		 (if (file-exists-p blgrep-buffer-file-name)
		     (find-file-noselect blgrep-buffer-file-name)
		   (error "No such file `%s'" blgrep-buffer-file-name)))))
    (cond
     ((eq win-frame 'window) (switch-to-buffer-other-window buf))
     ((eq win-frame 'frame) (switch-to-buffer-other-frame buf))
     (t (switch-to-buffer buf))))
  (goto-char (point-min))
  (when (stringp text-list)
    (setq text-list (list text-list)))
  (while text-list
    (if bol
	(re-search-forward (concat "^" (regexp-quote (car text-list))) nil t)
      (search-forward (car text-list) nil t))
    (setq text-list (cdr text-list)))
  (when pos
    (goto-char (- (point) pos))))

(defun blgrep-regrep (query &optional rev)
  (interactive "sQuery: \nP")
  (let ((grep-func (and (string-match "\\*\\([^:]+\\): " (buffer-name)) 
			(symbol-function (intern (match-string 1 (buffer-name))))))
	(buf (get-file-buffer blgrep-buffer-file-name)))
    (when (and buf grep-func)
      (switch-to-buffer buf)
      (funcall grep-func query rev))))

;;
;; blgrep common dummy functions
;;

(defalias 'blgrep-dummy 'undefined)
(defalias 'blgrep-next 'next-line)
(defalias 'blgrep-previous 'previous-line)
(defalias 'blgrep-forward 'forward-paragraph)
(defalias 'blgrep-backward 'backward-paragraph)

;;; blgrep.el ends here

;; Local Variables:
;; fill-column: 72
;; End:
