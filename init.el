(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-startup-message t)

;; Add .emacs.d to load-path
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)

;; ELPA
(setq package-user-dir (concat dotfiles-dir "elpa"))
(require 'package)
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")))
  (add-to-list 'package-archives source t))
(package-initialize)

;; Sort out the $PATH for OSX
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Key Bindings
(global-set-key (kbd "<C-f11>") 'nrepl-jack-in)
(global-set-key (kbd "<C-f12>") 'ns-toggle-fullscreen)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-c C-f") 'rgrep)

(setq backup-inhibited 'anyvaluebutnil)

;; C-c l/r to restore windows
(winner-mode 1)

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; Shows the kill ring
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-'") 'er/expand-region)

;; Minibuffer completion
(ido-mode)
(setq ido-enable-flex-matching t)

;; Parenthesis
(show-paren-mode)

;; hl-sexp
(require 'hl-sexp)

(add-hook 'clojure-mode-hook 'hl-sexp-mode)
(add-hook 'lisp-mode-hook 'hl-sexp-mode)
(add-hook 'emacs-lisp-mode-hook 'hl-sexp-mode)

;; highlight symbols
(add-hook 'clojure-mode-hook 'idle-highlight-mode)
(add-hook 'emacs-lisp-mode 'idle-highlight-mode)

(setq nrepl-history-file "~/.emacs.d/nrepl-history")
(setq nrepl-use-pretty-printing t)

;; eldoc
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)

;; Markdown mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Clojure mode for ClojureScript
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(require 'mustache-mode)
(add-to-list 'auto-mode-alist '("\.mustache$" . mustache-mode))

;; Dont like trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun compile-clj-when-save ()
  (if (string-match ".clj" (buffer-name)) (nrepl-load-current-buffer)))

;; compile into repl when saved
(add-hook 'after-save-hook 'compile-clj-when-save)

(dolist (file '("at-autocomplete.el"
		"at-ace-jump-mode.el"
		"at-multiple-cursors.el"
		"at-html"
		"at-clojure"
		"at-lnf.el"))
  (load (concat dotfiles-dir file)))


(global-auto-revert-mode t)
(put 'erase-buffer 'disabled nil)

(setenv "CLJ_FE_ZK_ROOT" "clj-fe-toni")
(setenv "CLJ_FE_ZK_CONN_STR" "10.251.76.40:2181,10.251.76.52:2181")

(custom-set-faces)

(require 'requirejs-mode)
(add-hook 'js2-mode-hook (lambda () (requirejs-mode)))
(add-hook 'javascript-mode-hook (lambda () (requirejs-mode)))

(add-hook 'clojure-mode-hook 'ac-source-lein-set-up)
(setq mm-url-use-external t)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'insfactor)

(add-hook 'prog-mode-hook
          '(lambda ()
             (yas-minor-mode)))

;; Paredit
(require 'paredit)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'enable-paredit-mode)
