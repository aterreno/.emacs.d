(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq frame-title-format "%b")
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(setq inhibit-splash-screen t)

;; Coloring
(require 'color-theme)

;(set-face-attribute 'default nil :height 100)
(set-face-attribute 'default nil :height 125 :font "Anonymous Pro")
;(set-face-attribute 'default nil :height 150 :font "Anonymous Pro")

;; Scrolling
(setq scroll-step 1)

;; show time
(setq display-time-24hr-format t)
(setq display-time-load-average t)
(display-time)

;; show column number
(column-number-mode t)

;; y/n hassle
(fset 'yes-or-no-p 'y-or-n-p)

(load-theme 'cyberpunk t)
