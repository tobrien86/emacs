(add-to-list 'load-path "~/.emacs.d/vendor")

;; Interface

;(modify-frame-parameters nil '((wait-for-wm . nil)))

; Font
;(set-default-font "Pragmata")

; Lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; No line-wrap
(setq default-truncate-lines t)

; No splash screen
(setq inhibit-splash-screen t)

; Line highlighting
(global-hl-line-mode t)

; Line numbering
(global-linum-mode t)

(add-to-list 'load-path "~/.emacs.d/vendor/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)

; Columns
(column-number-mode 1)
(setq-default fill-column 85)

;; Key bindings

; Invoke M-x with C-x C-m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

; Bind C-w to backward-kill-word, and C-x C-k to backward-kill-region
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


;; AUCTeX

(setq TeX-auto-save t
      TeX-parse-self t
      reftex-plug-into-AUCTeX t
      TeX-newline-function 'reindent-then-newline-and-indent
      TeX-electric-sub-and-superscript t
      )

(setq-default TeX-master nil)      

; Default modes
;(add-hook 'LaTeX-mode-hook 'flyspell-mode)   ; flyspell-mode
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ; math-mode
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)  ; reftex
(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)  ; auto-fill-mode

; RefTeX
(setq reftex-label-alist
      '(("thm"     ?h "thm:"  "~\\ref{%s}" t ("theorem" "thm"))
	("prop"    ?p "prop:" "~\\ref{%s}" t ("proposition" "prop"))
	("lem"     ?l "lem:"  "~\\ref{%s}" t ("lemma" "lem"))
	("cor"     ?c "cor:"  "~\\ref{%s}" t ("corollary" "cor"))
	("rem"     ?r "rem:"  "~\\ref{%s}" t ("remark" "rem"))
	("example" ?x "ex:"   "~\\ref{%s}" t ("example"))))

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (LaTeX-add-environments
	     '("thm" LaTeX-env-label)
	     '("prop" LaTeX-env-label)
	     '("lem" LaTeX-env-label)
	     '("cor" LaTeX-env-label)
	     '("rem" LaTeX-env-label)
	     '("example" LaTeX-env-label))))

;; ido-mode

(ido-mode t)
(setq ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-max-prospects 10)

; Disables ido-copy-current-file-name to play nice with backward-kill-word
(add-hook 'ido-setup-hook
	  (lambda ()
	    (define-key ido-completion-map "\C-w" nil)))


;; org-mode and remember
(require 'org-install)

(add-to-list 'load-path "~/emacs.d/vendor/remember")
;(require 'remember)
(org-remember-insinuate)
(setq org-directory "~/org")
(setq org-default-notes-file "~/.notes.org")
(global-set-key "\C-cr" 'org-remember)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


(setq org-remember-templates
      '(("LaTeX" ?l "* %^{Title}\n %?\n %a" "~/org/LaTeX.org")
	("Todo" ?t "* TODO %^{Brief description} %^g\n%?\nAdded: %U" "~/org/gtd.org" "Tasks")))

(setq org-agenda-files (list "~/org/gtd.org"
			     "~/org/LaTeX.org"))


;; Python stuff

; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

; Ropemacs
(pymacs-load "ropemacs" "rope-")


; Yasnippet
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet-0.5.10")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet-0.5.10/snippets")


; C++
(c-add-style "my-style"
	     '("stroustrup"
	       (c-basic-offset . 4)))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (c-set-style "my-style")
	    (auto-fill-mode)))