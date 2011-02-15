;;; clgrep.el --- ChangeLog Memo grep -*-emacs-lisp-*-

;; Copyright (C) 2004 Masayuki Ataka <ataka@milk.freemail.ne.jp>

;; Author: Masayuki Ataka <ataka@milk.freemail.ne.jp>
;; Keywords: tools, convenience

;; This file is a part of blgrep.

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

;; [Overview]
;;
;; clgrep.el is a part of blgrep package.
;;
;; clgrep collects all entries or items of ChangeLog Memo containing a
;; match for regexp.  See section "Change Logs" in `GNU Emacs Reference
;; Manual' for the term of ChangeLog.  See also commentary section of
;; blg-changelog.el for the term of ChangeLog.
;;
;; clgrep works with clmemo.el which provides clmemo-mode (ChangeLog
;; Memo mode).  So you should get clmemo.el for compiling and using
;; clgrep.el.  The latest clmemo.el is available at:
;;
;;   http://isweb22.infoseek.co.jp/computer/pop-club/emacs/changelog.html
;;
;; * Frontend of clgrep
;;
;; - clgrep
;;      Look for QUERY from every ITEM.
;; - clgrep-item-heading
;;      Look for QUERY from the first line of ITEM.
;; - clgrep-date
;;      Look for QUERY from the first line of ENTRY, which normally
;;      contains date, author name, e-mail address.
;;

;; [Install]
;;
;; (1) Get the latest clmemo.el and copy it to the directory where
;;     clgrep.el exists.
;; (2) Edit Makefile:
;;   [old:15] EXT    = #clgrep 
;;   [new:15] EXT    = clgrep 

;; [.emacs]
;;
;; Put this in your .emacs
;;
;;   (autoload 'clgrep "clgrep" "ChangeLog grep." t)
;;   (autoload 'clgrep-item-heading "clgrep" "ChangeLog grep for item heading" t)
;;   (autoload 'clgrep-date "clgrep" "ChangeLog grep for date line" t)
;;
;; It is good idea to bind them to your favourite keys:
;;
;;   (add-hook 'clmemo-mode-hook
;;             '(lambda ()
;;                (define-key clmemo-mode-map "\C-c\C-g" 'clgrep)))
;;

;; [History]
;;
;; * Satoru Takabayashi wrote original clgrep by Ruby in late 2001.
;;
;; * Masayuki Ataka ported it to EmacsLisp on 2002-03-19.
;;
;; * Masayuki Ataka rewrote clgrep.el from full stratch for blgrep
;;   package on 2004-07-03.
;;

;;; Code:
(eval-when-compile (require 'cl))

(require 'blgrep)
(require 'blg-changelog)
(require 'clmemo)
(provide 'clgrep)

(defun clgrep-internal (query rev)
  "Called from function `clgrep' and `clgrep-item-heading'."
  (flet ((blgrep-point-min    () (blg-changelog-point-min))
         (blgrep-beg-of-block () (re-search-backward blg-changelog-heading-regexp nil t))
         (blgrep-end-of-block () (re-search-forward blg-changelog-date-and-heading-regexp nil t)
                                 (beginning-of-line) (skip-syntax-backward "->"))
         (blgrep-up-block     () (re-search-backward blg-changelog-date-regexp nil t))
         (blgrep-top-p        () (looking-at blg-changelog-date-regexp)))
    (blgrep query rev #'clgrep-mode "clgrep" 1)))

;;;###autoload
(defun clgrep (query &optional rev)
  "ChangeLog grep."
  (interactive "sQuery: \nP")
  (flet ((blgrep-target-p     () (blg-changelog-looking-at "\t")))
    (clgrep-internal query rev)))

;;;###autoload
(defun clgrep-item-heading (query &optional rev)
  "ChangeLog grep for item heading"
  (interactive "sQuery in heading: \nP")
  (flet ((blgrep-target-p     () (blg-changelog-looking-at blg-changelog-heading-regexp)))
    (clgrep-internal query rev)))

;;;###autoload
(defun clgrep-date (query &optional rev)
  "ChangeLog grep for date line"
  (interactive "sQuery in date: \nP")
  (flet ((blgrep-point-min    () (blg-changelog-point-min))
         (blgrep-beg-of-block () (re-search-backward blg-changelog-date-regexp nil t))
         (blgrep-end-of-block () (re-search-forward blg-changelog-date-regexp nil t)
                                 (beginning-of-line) (skip-syntax-backward "->"))
         (blgrep-target-p     () (blg-changelog-looking-at blg-changelog-date-regexp)))
    (blgrep query rev #'clgrep-mode "clgrep" 1)))

;;
;; clgrep mode
;;

(defvar clgrep-mode-map (copy-keymap blgrep-mode-map))

(let ((old-map blgrep-mode-map)
      (new-map clgrep-mode-map))
  (define-key new-map "i" 'clgrep-item-heading)
  (define-key new-map "d" 'clgrep-date)
  (substitute-key-definition 'blgrep-dummy 'clgrep new-map old-map)
  (substitute-key-definition 'blgrep-next 'clmemo-next-item new-map old-map)
  (substitute-key-definition 'blgrep-previous 'clmemo-previous-item new-map old-map)
  (substitute-key-definition 'blgrep-forward 'clmemo-forward-entry new-map old-map)
  (substitute-key-definition 'blgrep-backward 'clmemo-backward-entry new-map old-map)
  (substitute-key-definition 'blgrep-jump 'clgrep-jump new-map old-map)
  (substitute-key-definition 'blgrep-jump-other-window 'clgrep-jump-other-window new-map old-map)
  (substitute-key-definition 'blgrep-jump-other-frame 'clgrep-jump-other-frame new-map old-map)
  (define-key new-map "t" 'clmemo-forward-tag)
  (define-key new-map "T" 'clmemo-backward-tag))

(define-derived-mode clgrep-mode change-log-mode "clgrep"
  "Major mode for clgrep."
  (run-hooks 'blgrep-mode-hook))

(defun clgrep-jump (&optional win-frame)
  "Jump to the source at point."
  (interactive)
  (let (cl-list (pos (point)))
    ;; To get cl-list
    (save-excursion
      ;; item
      (if (blg-changelog-looking-at blg-changelog-date-regexp)
          (progn
            (end-of-line)
            (setq pos (- (point) pos))
            (beginning-of-line))
        (let ((beg (progn (skip-syntax-forward "->")
                          (end-of-line)
                          (blg-changelog-previous-item)
                          (beginning-of-line) (point)))
              (end (progn (end-of-line)
                          (when (re-search-forward blg-changelog-date-and-heading-regexp nil t)
                            (beginning-of-line)
                            (skip-syntax-backward "->"))
                          (point))))
          (setq cl-list (list (buffer-substring-no-properties beg end))
                pos (- end pos))
          (blg-changelog-backward-entry)))
      ;; date
      (setq cl-list (cons (buffer-substring-no-properties
                           (point) (progn (end-of-line) (point)))
                          cl-list)))
    ;; Jump to text
    (blgrep-goto-source-at-point cl-list pos t win-frame)))

(defun clgrep-jump-other-window ()
  "Jump to the source at point in other window."
  (interactive)
  (clgrep-jump 'window))

(defun clgrep-jump-other-frame ()
  "Jump to the source at point in other frame."
  (interactive)
  (clgrep-jump 'frame))

;; clgrep.el ends here

;; Local Variables:
;; fill-column: 72
;; End:
