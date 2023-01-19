;; Red Hat Linux default .emacs initialization file

;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))
;;(defvar running-emacs (not running-xemacs))

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; load emacs 24's package system.  Add MELPA repositoy.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
   
  (package-initialize)

  ;; load some useful packages here....
  (unless (package-installed-p 'use-package) (package-refresh-contents) (package-install 'use-package))
)

;; Set the frame's title. %b is the name of the buffer. %+ indicates
;; the state of the buffer: * if modified, % if read only, or -
;; otherwise. Two of them to emulate the mode line. %f for the file
;; name. Incredibly useful!
(setq frame-title-format "Emacs: %b %+%+ %f")

;; define global functions....

;; display the ascii table...
(defun ascii-table()
   (interactive)
   (switch-to-buffer "ASCII*")
   (erase-buffer)
   (insert (format "ASCII characters up to number %d.\n" 254))
   (let ((i 0))
      (while (< i 254)
          (setq i (+ i 1))
          (insert (format "%4d 0x%03x %c\n" i i i))))

   (beginning-of-buffer))

;; Inserts a C function header.
(defun insert-function-header ()
  "Inserts a C function header."
  (interactive)
  (insert
   "/*************************************************************************************************************\n"
   "* Function: \n"
   "*\n"
   "* Abstract: \n"
   "*\n"
   "* Params  : \n"
   "*\n"
   "* Returns : \n"
   "*\n"
   "* Written : Created " (format-time-string comment-date-format (current-time)) " (G.K.Huber)\n"
   "*************************************************************************************************************/\n"
   )
  (message "Inserted function header")
  )

;; Inserts a C file header...
(defun insert-file-header()
  "Inserts a C-style file header."
  (interactive)
  (insert
   "/*************************************************************************************************************\n"
   "*  File    : "(buffer-name) "                                                                        \n"
   "*                                                                                                    \n"
   "*  Abstract:                                                                                         \n"
   "*                                                                                                    \n"
   "*  Signals :                                                                                         \n"
   "*                                                                                                    \n"
   "*  Slots   :                                                                                         \n"
   "*                                                                                                    \n"
   "*  Written : Created " (format-time-string comment-date-format (current-time)) " (G.K.Huber)         \n"
   "*************************************************************************************************************/\n"
   )
  (message "Inserted file header")
  )

;; Inserts a cpp class header...
(defun insert-class-header()
  "Inserts a cpp class header."
  (interactive)
  (insert
   "/*************************************************************************************************************\n"
   "* Class   :                                                                                          \n"
   "*                                                                                                    \n"
   "* Abstract:                                                                                          \n"
   "*                                                                                                    \n"
   "* Extends :                                                                                          \n"
   "*                                                                                                    \n"
   "* Members :                                                                                          \n"
   "*                                                                                                    \n"
   "* Written : Created " (format-time-string comment-date-format (current-time)) " (G.K.Huber)         \n"
   "*************************************************************************************************************/\n"
   )
  (message "Inserted file header")
  )  

;; Inserts a default cpp class body
(defun insert-cpp-class()
  "Inserts a C++ class which conforms to Oacis standards."
  (interactive)
  (insert
   "class _class_\n"
   "{\n"
   "public:\n"
   "\n"
   "	// Constructor/destructor.\n"
   "	_class_();\n"
   "	virtual ~_class_();\n"
   "\n"
   "private:\n"
   "\n"
   "	// Unused ctor and assignment op.\n"
   "	_class_(const _class_&);\n"
   "	_class_& operator=(const _class_&);\n"
   "};\n"
   "\n")
  (message "Inserted C++ class")
  )

;; Inserts a python function header
(defun insert-pyfun-header()
  "Inserts a Python function header."
  (interactive)
  (insert
   "#########################################################################################################\n"
   "# Function:                                                                                              \n"
   "# Abstract:                                                                                              \n" 
   "# Params  : self -- [in] self-referential reference.                                                     \n"
   "# Returns :                                                                                              \n"
   "# Written : Created " (format-time-string comment-date-format (current-time)) "(G.K.Huber)               \n"
   "#########################################################################################################\n")
   (message "Inserted Python function header")
   )


; Insert the date, the time, and the date and time at point. Insert the
; date 31 days hence at point (eventually...). Useful for keeping
; records. These are based on Glickstein.
(defun insert-month-date ()
  "Insert the date 31 days from now according to the variable \"insert-date-format\"."
  (interactive "*")
  (insert (format-time-string insert-date-format (current-time)))) 

(defvar insert-time-format "%T"
  "*Format for \\[insert-time] (c.f. 'format-time-string' for how to format).")

(defvar insert-date-format "%Y %m %d"
  "*Format for \\[insert-date] (c.f. 'format-time-string' for how to format).")

(defvar comment-date-format "%b %Y"
  "*Format for \\[insert-comment] (c.f. 'format-time-string' for how to format).")

(defun insert-time ()
  "Insert the current time according to the variable \"insert-time-format\"."
  (interactive "*")
  (insert (format-time-string insert-time-format (current-time))))

(defun insert-date ()
  "Insert the current date according to the variable \"insert-date-format\"."
  (interactive "*")
  (insert (format-time-string insert-date-format (current-time))))

(defun insert-time-and-date ()
  "Insert the current date according to the variable \"insert-date-format\", then a space, then the current time according to the variable \"insert-time-format\"."
  (interactive "*") (progn (insert-date) (insert " ") (insert-time)))

(defun insert-comment-date ()
  "Insert the month/year a comment change was made, format according to \"comment-date-format\"."
  (interactive "*")
  (insert (format-time-string comment-date-format (current-time))))

(defun today ()
  "Insert string for today's date nicely formatted in American style, e.g. Sunday, September 17, 2000 or standard 17-09-2000."
  (interactive)                                       ; permit invocation in minibuffer
  ;;(insert (format-time-string "%A, %B %e, %Y")))    ; American style (Sunday, September 17, 2000
  (insert (format-time-string "%d-%m-%y")))             ; standard style (17Oct2000)

;convert a buffer from dos ^M end of lines to unix end of lines
(defun dos2unix ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\r" nil t) (replace-match "")))

;convert a buffer from unix end of lines to dox ^M end of lines.
(defun unix2dos ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\n" nil t) (replace-match "\r\n")))


(defun balle-grep-todos-in-dir (dir &optional not-recursive)
   "Grep recursively for TODO comments in the given directory"
   (interactive "Ddirectory:")
      (let ((recur "-r"))
	(if not-recursive
	    (setq recur ""))
	(grep (concat "grep -nH -I " recur " -E \"[\\#\\/\\-\\;\\*]\s*TODO|FIXME|XXX:?\" " dir " 2>/dev/null")))
      (enlarge-window 7))

(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )

;; add line numbers by default
(autoload 'linum-mode "linum" "toggle line numbers on/off" t)

;; pull in xcscope
;;(require 'xcscope)


;; set up function keys....
(global-set-key [f1] 'manual-entry)
(global-set-key [(shift f1)] 'insert-pyfun-header)

;; key bindings for documentation aids
(global-set-key [f2] 'insert-function-header)                                 ;; insert function header
(global-set-key [(shift f2)] 'insert-file-header)                             ;; insert class header
(global-set-key [(control f2)] 'insert-class-header)                          ;; insert class block

;; key bindings for searching 
(global-set-key [f3] 'nonincremental-search-forward)                          ;; search forward
(global-set-key [(shift f3)] 'nonincremental-repeat-search-forward)           ;; repeat search, forward
(global-set-key [(control f3)] 'nonincremental-repeat-search-backward)        ;; repeat search, backwards
(global-set-key [(meta f3)] 'isearch-forward)                                 ;; interactive search

;; TODO : bind search/replace functions to f4

;; key bindings for error walking
(global-set-key [f5] 'next-error)
(global-set-key [(shift f5)] 'previous-error)
(global-set-key (kbd "C-<f5>") 'linum-mode)

;; key bindings for utility functions
(global-set-key [f6] 'dos2unix)
(global-set-key [(shift f6)] 'unix2dos)
(global-set-key [(control f6)] 'ascii-table)

;; key bindings for compilations
(global-set-key [f7] 'compile)
(global-set-key [(shift f7)] 'kill-compilation)
(global-set-key [(control f7)] 'balle-grep-todos-in-dir)                       ;; build a TODO list

;; key bindings for use with org mode
(global-set-key [f8] 'today)
(global-set-key [(shift f8)]'insert-comment-date )
(global-set-key [(control f8)] 'insert-time)

;; easy spell check
(global-set-key (kbd "<f9>") 'ispell-word)
(global-set-key (kbd "C-S-<f9>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f9>") 'flyspell-buffer)
(global-set-key (kbd "C-<f9>") 'flyspell-check-previous-highlighted-word)
(global-set-key (kbd "M-<f9>") 'flyspell-check-next-highlighted-word)

;; cscope tags
(global-set-key [f10] 'cscope-set-initial-directory)       
(global-set-key [(shift f10)] 'cscope-find-this-symbol)
(global-set-key [(control f10)] 'cscope-display-buffer)

;; set up custom colors for various items in major mode...
(cond ((fboundp 'global-font-lock-mode)
      (setq font-lock-face-attributes
           '((font-lock-comment-face              "salmon1")
             (font-lock-string-face               "pale green")
             (font-lock-keyword-face              "cyan")
             (font-lock-function-name-face        "khaki")
             (font-lock-variable-name-face        "cyan")
             (font-lock-type-face                 "White")
;;           (font-lock-reference-face            "Purple")
            ))
       (require 'font-lock)
       (setq font-lock-maximum-decoration t)
       (global-font-lock-mode t)))

;; Always end a file with a newline
(setq require-final-newline t)

;; make TODO's and NOTE's in a different color
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode python-mode))
 (make-face 'font-lock-fixme-face)
 (make-face 'font-lock-note-face)
 (mapc (lambda (mode)
	 (font-lock-add-keywords
	  mode
	  '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
            ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
	fixme-modes)
 (modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
 (modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; remap key bindings
(global-unset-key "\C-z")                                  ;; unmap ctrl-z 

(global-set-key "\M-g" 'goto-line)                         ;; Esc-G     : goto-line
(global-set-key [home] 'beginning-of-line)                 ;; home      : beginning of line
(global-set-key [end] 'end-of-line)                        ;; end       : end of line
(global-set-key [\C-home] 'beginning-of-buffer)            ;; ctrl-home : beginning of buffer
(global-set-key [\C-end] 'end-of-buffer)                   ;; ctrl-end  : end of buffer
(global-set-key "\C-z" 'undo)                              ;; ctrl-z    : undo

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.  Your init file should contain only 
 ;; one such instance. If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(lpr-headers-switches nil)
 '(lpr-page-header-switches '("--form-feed --length=55"))
 '(package-selected-packages
   '(lsp-mode proof-general go-mode exec-path-from-shell auto-complete)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.  If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.  If there is more than one, they won't
 ;; work right.
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "adobe-courier"))))
 '(makefile-space-face ((((class color)) (:background "firebrick1")))))

(set-background-color "black")         ; set background color to black
(set-foreground-color "white")         ; set forground color to white
(set-cursor-color "wheat")             ; set cursor color to wheat
(set-face-background 'region "gray")   ; set background color of region to gray
(set-face-foreground 'region "white")
;;(set-face-foreground 'modeline "gold1")
;;(set-face-background 'modeline "dim gray")

;; set the defaule size of the emacs windw - 
(set-frame-height (selected-frame) 45)
(set-frame-width (selected-frame) 85)
(set-frame-position (selected-frame) 2000 5)   ;; set so frame would open on main monitor (middle)

;; set up the auto-mode list...
(setq auto-mode-alist
      (append '(
                ("\\.s?html?\\'" . html-helper-mode)
                ("\\.asp$" . html-helper-mode)
                ("\\.as[phm]x$" . html-helper-mode)
                ("\\.html$" . html-helper-mode)
                ("\\.htm$" . html-helper-mode)
                ("\\.md$" . emacs-lisp-mode)
                ("\\.txt$" . text-mode)
                ("\\.cs$" . csharp-mode)
                ) auto-mode-alist ))


;; set up C and C++ mode...
(defun my-c++-mode-hook()
  (setq tab-width 4)
  (define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c++-mode-map "\C-ce" 'c-comment-edit)
  (setq c++-auto-hungry-initial-state 'none)
  (setq c++-delete-function 'backward-delete-char)
  (setq c++-tab-always-indent t)
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c++-empty-arglist-indent 4)
  (setq c-brace-offset -4)
  (setq c-label-offset -4)
  (setq c-auto-newline nil) 
  (c-set-offset 'substatement-open 0)         ;; align brackes with first character
  (c-set-offset 'statement-case-open 0)       ;; case statement zero indent
  (c-set-offset 'case-label '+)               ;; indent case line from switch
)

(defun my-c-mode-hook()
  (setq tab-width 4)
  (define-key c-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c-mode-map "\C-ce" 'c-comment-edit)
  (setq c-auto-hungry-initial-state 'none)
  (setq c-delete-function 'backward-delete-char)
  (setq c-tab-always-indent t)
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c-brace-offset -4)
  (setq c-argdecl-indent 0)
  (setq c-label-offset -4)
  (setq c-auto-newline nil) 
  (c-set-offset 'substatement-open 0)         ;; align brackes with first character
  (c-set-offset 'statement-case-open 0)       ;; case statement zero indent
  (c-set-offset 'case-label '+)               ;; indent case line from switch
)

;; set up Perl mode...
(defun my-perl-mode-hook()
  (setq tab-width 4)
  (define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (setq perl-indent-level 4)
  (setq perl-continued-statement-offset 4))

;; set up Emacs-Lisp mode...
(defun my-lisp-mode-hook()
  (define-key lisp-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key lisp-mode-map "\C-i" 'lisp-indent-line)
  (define-key lisp-mode-map "\C-j" 'eval-print-last-sexp))

;; set up HTML mode...
(autoload 'html-helper-mode "html-helper-mode" "HTML Helper Mode" t)

;; set up C# mode
(autoload 'csharp-mode "cc-mode")

(c-add-style "myC#Style"
  '("C#"
  (c-basic-offset . 2)
  (c-comment-only-line-offset . (0 . 0))
  (c-offsets-alist . (
    (c                     . c-lineup-C-comments)
    (inclass               . 0)
    (namespace-open        . +)
    (namespace-close       . +)
    (innamespace           . 0)
    (class-open            . +)
    (class-close           . +)
    (inclass               . 0)
    (defun-open            . +)
    (defun-block-intro     . 0)
    (inline-open           . +)
    (inline-close          . 0)
    (statement-block-intro . 0)
    (statement-cont        . +)
    (brace-list-intro      . +)
    (topmost-intro-cont    . 0)
    (block-open            . +)
    (block-close           . 0)
    (arglist-intro         . +)
    (arglist-close         . 0)
    ))
  ))

(defun my-csharp-mode-hook ()
  (cond (window-system
         (turn-on-font-lock)
         (c-set-style "myC#Style")
         )))

;; stuff for golang
(setenv "GOPATH" "/usr/bin")
(add-to-list 'exec-path "/usr/bin")


(defun my-go-mode-hook ()
  (setq tab-width 4)
  ; Call gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v  go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)


(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'auto-mode-alist '("\\.nasm$" . nasm-mode))


;; set up fly-spell for text related modes...
(require 'ispell)
(autoload 'flyspell-mode "flyspell" "On-the-fly ispell." t)
(autoload 'global-flyspell-mode "flyspell" "On-the-fly ispell." t)
(setq ispell-enable-tex-parser t)


;; add all of the hooks....
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'perl-mode-hook 'my-perl-mode-hook)
(add-hook 'csharp-mode-hood 'my-csharp-mode-hook)
(add-hook 'text-mode-hook 'flyspell-mode)

;; complement to next error
(defun previous-error(n)
   "Visit previous compilation error message and cooresponding source code."
   (interactive "p")
   (next-error(-n)))

;; display time in the mode line...
(setq display-time-24h-format t)
(display-time)

;; display column numbers, and line numbers
(column-number-mode `t)
(global-linum-mode `t)

;; change yes-or-no questions to y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; setup auto-save features.  Autosave every five minutes
(setq auto-save-timeout 300)
(setq auto-save-interval 300)
(setq auto-save-timeout nil)

;; misc...
(setq compile-command "make")



;; make point more likely to return to where it had been after several
;; scroll operation.
(setq scroll-preserve-screen-position t)

;; Calendar stuff is common to every emacs version 
(if (not ( or (string-equal system-name "server.localdomain" )
	      (string-equal system-name "tester.localdomain" )))
    (progn
      ;; set my home co-ordinates for sunrise/sunset calculations
      (setq calendar-latitude 39.20)
      (setq calendar-longitude -76.72)
      (setq calendar-location-name "Hanover, MD")
      (calendar)			; fire up the calendar display.
      (setq number-of-diary-entries [2 3 3 3 3 5 2])
      (add-hook 'diary-display-hook 'fancy-diary-display)
      (setq appt-audible nil)
      (diary)
      ))
;; end calendar/diary stuff

(setq time-stamp-line-limit 16)

;; globrep, to do global search and replace on a number of files.
(setq grep-command "grep -i -n ")
 (autoload 'global-replace-lines "globrep"
   "Put back grepped lines" t)
 (autoload 'global-replace "globrep"
   "query-replace across files" t)
 (autoload 'global-grep-and-replace "globrep"
   "grep and query-replace across files" t)


