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
      )

(setq-default TeX-master nil)      

; Default modes
(add-hook 'LaTeX-mode-hook 'flyspell-mode)   ; flyspell-mode
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ; math-mode
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)  ; reftex
(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)  ; auto-fill-mode


;; ido-mode

(ido-mode t)
(setq ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-max-prospects 10)

; Disables ido-copy-current-file-name to play nice with backward-kill-word
(add-hook 'ido-setup-hook
	  (lambda ()
	    (define-key ido-completion-map "\C-w" nil)))