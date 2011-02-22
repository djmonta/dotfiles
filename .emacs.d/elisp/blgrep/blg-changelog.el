;;; blg-changelog.el --- ChangeLog grep -*-emacs-lisp-*-

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
;; blg-changelog.el is a part of blgrep package.
;;
;; blg-changelog collects all entries or items of ChangeLog containing a
;; match for regexp.  See section "Change Logs" in `GNU Emacs Reference
;; Manual' for the term of ChangeLog.
;;
;; * This is a short sample of ChangeLog (GNU Format):
;;   ,
;;  |           2001-01-02  Masayuki Ataka  <ataka@foo.org>
;;  |     ,
;; (1)   |      <-TAB-> * filename.el (function-name): New function.
;;  E  (2)ITEM          In the part of `function-name', author write
;;  N    |              variable-name, option-name and etc.
;;  T     '
;;  R                   * changelog.el (cl-sample): Doc fix.
;;  Y                   (change-log-show-sample): Fix typo.
;;  |                   (change-log-sample-name): New variable.
;;  |
;;   '          2001-01-01  Masayuki Ataka  <ataka@foo.org>
;;
;;                      * filename.el: New file.  This file is written
;;                      for a short sample of ChangeLog file in GNU
;;                      format.
;;
;; (1) ENTRY starts with a header line that contains the date, author
;;     name and his email address.  ENTRY consists of some ITEMs.
;;
;; (2) ITEM is indented by one TAB.  ITEM starts with `*'(asterisk),
;;     that follows FILE NAME and FUNCTION NAME (or variable, macro,
;;     user option, etc...).  Normally there should be blank line
;;     between each items.
;;
;; We call the first line of ENTRY DATE-LINE and the first line of ITEM
;; ITEM-HEADING.
;;
;; * Frontend of blg-changelog
;;
;; - blg-changelog
;;      Look for QUERY from every ITEM.
;; - blg-changelog-item-heading
;;      Look for QUERY from the first line of ITEM.
;; - blg-changelog-date
;;      Look for QUERY from the first line of ENTRY, which normally
;;      contains date, author name, e-mail address.
;;

;; [.emacs]
;;
;; Put this in your .emacs
;;
;;   (autoload 'blg-changelog "blg-changelog" "ChangeLog grep." t)
;;   (autoload 'blg-changelog-item-heading "blg-changelog" "ChangeLog grep for item heading" t)
;;   (autoload 'blg-changelog-date "blg-changelog" "ChangeLog grep for date line" t)
;;
;; It is good idea to bind them to your favourite keys:
;;
;;   (add-hook 'change-log-mode-hook
;;             '(lambda ()
;;                (define-key change-log-mode-map "\C-c\C-g" 'blg-changelog)
;;                (define-key change-log-mode-map "\C-c\C-i" 'blg-changelog-item-heading)
;;                (define-key change-log-mode-map "\C-c\C-d" 'blg-changelog-date)))
;;

;;; Code:
(eval-when-compile (require 'cl))

(require 'blgrep)
(provide 'blg-changelog)

;;
;; System Variables
;;

(defvar blg-changelog-date-regexp "^\\<.")
(defvar blg-changelog-heading-regexp "^\t\\*")
(defvar blg-changelog-date-and-heading-regexp "^\\(\\<.\\|\t\\*\\)")

;;; Comment ;;;
;; `.' (dot) in the blg-changelog-date-regexp is a trick.  Function
;; search-forward-regexp matches the beginning of line of date in
;; ChangeLog with regexp "^\\<".  If the function takes optional
;; argument COUNT, it matches the beginning-of-line again and again
;; because point does not moves by the secondary effect of serch
;; function.  That is an unexpected effect of matching empty string.

(defun blg-changelog-internal (query rev)
  "Called from function `blg-changelog' and `blg-changelog-item-heading'."
  (flet ((blgrep-point-min    () (blg-changelog-point-min))
         (blgrep-beg-of-block () (re-search-backward blg-changelog-heading-regexp nil t))
         (blgrep-end-of-block () (re-search-forward blg-changelog-date-and-heading-regexp nil t)
                                 (beginning-of-line) (skip-syntax-backward "->"))
         (blgrep-up-block     () (re-search-backward blg-changelog-date-regexp nil t))
         (blgrep-top-p        () (looking-at blg-changelog-date-regexp)))
    (blgrep query rev #'blg-changelog-mode "blg-changelog" 1)))

(defmacro blg-changelog-looking-at (regexp)
  "Return t if REGEXP matches at the beginning of line."
  (list 'save-excursion
        '(beginning-of-line)
        `(looking-at ,regexp)))

;;;###autoload
(defun blg-changelog (query &optional rev)
  "ChangeLog grep."
  (interactive "sQuery: \nP")
  (flet ((blgrep-target-p     () (blg-changelog-looking-at "\t")))
    (blg-changelog-internal query rev)))

;;;###autoload
(defun blg-changelog-item-heading (query &optional rev)
  "ChangeLog grep for item heading"
  (interactive "sQuery in heading: \nP")
  (flet ((blgrep-target-p     () (blg-changelog-looking-at blg-changelog-heading-regexp)))
    (blg-changelog-internal query rev)))

;;;###autoload
(defun blg-changelog-date (query &optional rev)
  "ChangeLog grep for date line"
  (interactive "sQuery in date: \nP")
  (flet ((blgrep-point-min    () (blg-changelog-point-min))
         (blgrep-beg-of-block () (re-search-backward blg-changelog-date-regexp nil t))
         (blgrep-end-of-block () (re-search-forward blg-changelog-date-regexp nil t)
                                 (beginning-of-line) (skip-syntax-backward "->"))
         (blgrep-target-p     () (blg-changelog-looking-at blg-changelog-date-regexp)))
    (blgrep query rev #'blg-changelog-mode "blg-changelog" 1)))

;
;; aliases
;
(defalias 'clgrep 'blg-changelog)
(defalias 'clgrep-item-heading 'blg-changelog-item-heading)
(defalias 'clgrep-date 'blg-changelog-date)

(defun blg-changelog-point-min ()
  "Return the minimum value of point in the ChangeLog.
If file starts with a copyright and permission notice, skip them.
Assume they end at first blank line."
  (when (looking-at "Copyright")
    (search-forward "\n\n")
    (skip-chars-forward "\n"))
  (point))

;;
;; blg-changelog mode
;;

(defvar blg-changelog-mode-map (copy-keymap blgrep-mode-map))

(let ((old-map blgrep-mode-map)
      (new-map blg-changelog-mode-map))
  (define-key new-map "i" 'blg-changelog-item-heading)
  (define-key new-map "d" 'blg-changelog-date)
  (substitute-key-definition 'blgrep-dummy 'blg-changelog new-map old-map)
  (substitute-key-definition 'blgrep-next 'blg-changelog-next-item new-map old-map)
  (substitute-key-definition 'blgrep-previous 'blg-changelog-previous-item new-map old-map)
  (substitute-key-definition 'blgrep-forward 'blg-changelog-forward-entry new-map old-map)
  (substitute-key-definition 'blgrep-backward 'blg-changelog-backward-entry new-map old-map)
  (substitute-key-definition 'blgrep-jump 'blg-changelog-jump new-map old-map)
  (substitute-key-definition 'blgrep-jump-other-window 'blg-changelog-jump-other-window new-map old-map)
  (substitute-key-definition 'blgrep-jump-other-frame 'blg-changelog-jump-other-frame new-map old-map))

(define-derived-mode blg-changelog-mode change-log-mode "blg-changelog"
  "Major mode for blg-changelog."
  (run-hooks 'blgrep-mode-hook))


(defun blg-changelog-next-item (&optional arg)
  "Move to the beginning of the next item
With argument ARG, do it ARG times;
a negative argument ARG = -N means move previous N items."
  (interactive "p")
  (re-search-forward blg-changelog-heading-regexp nil t arg)
  (beginning-of-line)
  (skip-chars-forward "\t"))

(defun blg-changelog-previous-item (&optional arg)
  "Move to the beginning of the previous item
With argument ARG, do it ARG times;
a negative argument ARG = -N means move next N items."
  (interactive "p")
  (re-search-backward blg-changelog-heading-regexp nil t arg)
  (skip-chars-forward "\t"))

(defun blg-changelog-forward-entry (&optional arg)
  "Move forward to beginning of entry.
With argument ARG, do it ARG times;
a negative argument ARG = -N means move backward N entries."
  (interactive "p")
  (if (and arg (< arg 0))
      (blg-changelog-backward-entry (- arg))
    (beginning-of-line)
    (forward-char 1)
    (re-search-forward blg-changelog-date-regexp nil t arg)
    (beginning-of-line)))

(defun blg-changelog-backward-entry (&optional arg)
  "Move backward to beginning of entry.
With argument ARG, do it ARG times;
a negative argument ARG = -N means move forward N entries."
  (interactive "p")
  (if (and arg (< arg 1))
      (blg-changelog-forward-entry (- arg))
    (beginning-of-line)
    (backward-char 1)
    (re-search-backward blg-changelog-date-regexp nil t arg)
    (beginning-of-line)))

(defun blg-changelog-jump (&optional win-frame)
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

(defun blg-changelog-jump-other-window ()
  "Jump to the source at point in other window."
  (interactive)
  (blg-changelog-jump 'window))

(defun blg-changelog-jump-other-frame ()
  "Jump to the source at point in other frame."
  (interactive)
  (blg-changelog-jump 'frame))

;; blg-changelog.el ends here

;; Local Variables:
;; fill-column: 72
;; End:
