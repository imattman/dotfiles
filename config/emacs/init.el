;; Mattman's emacs config
;; -------------------------

;(when window-system (set-frame-size (selected-frame) 85 40))

(load-theme 'deeper-blue t)
;(load-theme 'wombat t)

(setq inhibit-startup-message t)  ;; disable start up screen
(tool-bar-mode -1)                ;; 
;(toggle-scroll-bar -1)

;(setq initial-scratch-message "") ;; hide scratch buffer help

;; note the visual warning causes problems on OS X
(setq ring-bell-function 'ignore) ;; disable audio/visual warning

(global-linum-mode t)             ;; enable line numbers
(setq default-tab-width 4)        ;; use 4 because 8 is too wide


;(print (font-family-list))
(set-face-attribute 'default nil
  :family "Hack Nerd Font" :height 160 :weight 'normal)
;  :family "FiraCode Nerd Font" :height 160 :weight 'normal)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("elpa" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)

;; bootstrap 'use-package'
(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))

(use-package which-key
  :ensure t)

(use-package try
  :ensure t)

