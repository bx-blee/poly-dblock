;;; comeega.el --- Org-mode Enhanced Authorship   -*- Mode: Emacs-Lisp; lexical-binding: t; -*-
;;
;; Copyright (C) 2021-2022 Mohsen BANAN - http://mohsen.1.banan.byname.net/contact
;;
;; Author: Mohsen BANAN <emacs@mohsen.1.banan.byname.net>
;; Maintainer: Mohsen BANAN <emacs@mohsen.1.banan.byname.net>
;; Created: February 03, 2022
;; Keywords: languages lisp
;; Homepage: https://github.com/bx-blee/comment-block
;; Package-Requires: ((emacs "25.1"))
;; Package-Version: 0.1
;;
;; This file is not part of GNU Emacs.
;; This file is part of Blee (ByStar Libre-Halaal Emacs Environment).
;;
;; This is Libre-Halaal Software intended to perpetually remain Libre-Halaal.
;; See http://mohsen.1.banan.byname.net/PLPC/120033 for details.
;; _Copyleft_: GNU AFFERO GENERAL PUBLIC LICENSE --- [[file:../LICENSE]]
;;
;;; Commentary:
;;
;;  COMEEGA (Collaborative Org-Mode Enhanced Emacs Generalized Authoring)
;;  See https://github.com/bx-blee/comeega for a conceptual overview.
;;
;;  The major-mode for a given comeega-file can be switched between:
;;  1) native-mode      --- comeega-native/switch Command
;;  2) poly-native-mode --- comeega-poly-native/switch Command
;;  3) org-mode         --- comeega-org/switch Command
;;
;;  Blee keybinding for these are provided and you can customize as you wish.
;;
;;; Code:

(require 's)

;;;
;;; (comeega-polymode|getForMode major-mode)
;;;
(defun comeega-polymode|getForMode (<major-mode)
  "Given <MAJOR-MODE, return corresponding polymode as a symbol.
Mapping between <MAJOR-MODE  and polymode is by prefixing it with 'comeega-poly-'"
  (let* (
         ($major-mode-str (symbol-name <major-mode))
         ($polymodeAsStr (s-lex-format "comeega-poly-${$major-mode-str}"))
         ($polymodeAsSymbol (intern-soft $polymodeAsStr)))
    (unless $polymodeAsSymbol
      (error (s-lex-format
              "Missing symbol -- ${$polymodeAsStr}")))
    $polymodeAsSymbol))

(provide 'comeega)
;;; comeega.el ends here



(defun org-dblock-mode-comment-regexp-bx ()
  "based on major-mode set regexp for org-dblock-update"
  (interactive)
  (cond ((string-equal "emacs-lisp-mode" major-mode)
	 (setq org-dblock-start-re "^[ 	]*\;\;\;#\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	 (setq org-dblock-end-re "^[ 	]*\;\;\;#\\+END\\([: 	
\n]\\|$\\)")
	 (message "Set to: ;;;#+BEGIN...")
	 )
	((string-equal "latex-mode" major-mode)
	 (setq org-dblock-start-re "^[ 	]*%%%#\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	 (setq org-dblock-end-re "^[ 	]*%%%#\\+END\\([: 	
\n]\\|$\\)")
	 ;;;(message "Set to: \%\%\%#+BEGIN...")
	 (message "Set to: 3percents#+BEGIN...")
	 )
	((string-equal "shell-script-mode" major-mode)
	 (setq org-dblock-start-re "^[ 	]*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	 (setq org-dblock-end-re "^[ 	]*####\\+END\\([: 	
\n]\\|$\\)")
	 (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	 )
	((string-equal "html-mode" major-mode)
	 (setq org-dblock-start-re "^.*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	 (setq org-dblock-end-re "^.*####\\+END\\([: 	
\n]\\|$\\)")
	 (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	 )
	(t
	 (setq org-dblock-start-re "^.*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	 (setq org-dblock-end-re "^.*####\\+END\\([: 	
\n]\\|$\\)")
	 (message (format "major-mode: %s - dblock re unchanged" major-mode))
	 ))
  )


;;;  ["Set Start/End Mode RegExp" (org-dblock-mode-comment-regexp-bx) t]
;;;  adding as mode hook
;;;   (org-dblock-mode-comment-mode-hook-bx)
(lambda () "
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || defun        :: (org-dblock-mode-comment-mode-hook-bx) [[elisp:(org-cycle)][| ]]
")

(defun org-dblock-mode-comment-mode-hook-bx ()
  "based on major-mode set regexp for org-dblock-update"
  (interactive)
  (add-hook 'emacs-lisp-mode-hook
	    '(lambda ()
	       (setq org-dblock-start-re "^[ 	]*\;\;\;#\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re "^[ 	]*\;\;\;#\\+END\\([: 	
\n]\\|$\\)")
  	       (message "Set to: ;;;#+BEGIN...")
	       ;;;(message "Set to: 3semicolon#+BEGIN...")	 
	       ))
  (add-hook 'latex-mode-hook 
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^[ 	]*%%%#\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^[ 	]*%%%#\\+END\\([: 	
\n]\\|$\\)")
	       ;;;(message "Set to: %%%#+BEGIN...")
	       (message "Set to: 3percents#+BEGIN...")
	       ))
  (add-hook 'LaTeX-mode-hook 
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^[ 	]*%%%#\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^[ 	]*%%%#\\+END\\([: 	
\n]\\|$\\)")
	       (message "Set to: 3percets#+BEGIN for LaTeX mode")
	       ))
  (add-hook 'shellscript-mode-hook
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^[ 	]*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^[ 	]*####\\+END\\([: 	
\n]\\|$\\)")
	       (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	       ))
  (add-hook 'sh-script-mode-hook
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^[ 	]*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^[ 	]*####\\+END\\([: 	
\n]\\|$\\)")
	       (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	       ))
  (add-hook 'sh-mode-hook
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^[ 	]*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^[ 	]*####\\+END\\([: 	
\n]\\|$\\)")
	       (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	       ))
  (add-hook 'html-mode-hook
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^.*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^.*####\\+END\\([: 	
\n]\\|$\\)")
	       (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	       ))
  (add-hook 'message-mode-hook
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^.*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^.*####\\+END\\([: 	
\n]\\|$\\)")
	       (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	       ))
  (add-hook 'org-mode-hook
	    '(lambda ()
	       (setq org-dblock-start-re 
		     "^.*####\\+BEGIN:[ 	]+\\(\\S-+\\)\\([ 	]+\\(.*\\)\\)?")
	       (setq org-dblock-end-re 
		     "^.*####\\+END\\([: 	
\n]\\|$\\)")
	       (message (format "Set to: %s -  ####+BEGIN..." major-mode))
	       ))
  )



(provide 'comeega)
;;; comeega.el ends here

