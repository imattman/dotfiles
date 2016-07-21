;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; -------------------------

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy             ;; python lang
    flycheck         ;; flycheck instead of older flymake
    material-theme))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)


(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))



;; BASIC CUSTOMIZATION
;; -------------------------

(setq inhibit-startup-message t) ;; hide start up screen
(load-theme 'material t)
(global-linum-mode t) ;; enable line numbers

;; note the visual warning causes problems on OS X
(setq ring-bell-function 'ignore) ;; disable audio/visual warning

(set-face-attribute 'default nil
                :family "Inconsolata" :height 180 :weight 'normal)
;; (set-face-attribute 'default nil
;;                 :family "Monaco" :height 180 :weight 'normal)

;; end of init.el
