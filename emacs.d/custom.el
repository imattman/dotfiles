;; BASIC CUSTOMIZATION
;; -------------------------

;(load-theme 'material t)
(load-theme 'wombat t)

(setq inhibit-startup-message t)  ;; hide start up screen
(setq initial-scratch-message "") ;; no need for clarification

(global-linum-mode t)             ;; enable line numbers

;; note the visual warning causes problems on OS X
(setq ring-bell-function 'ignore) ;; disable audio/visual warning

(set-face-attribute 'default nil
  :family "Inconsolata" :height 180 :weight 'normal)
;; (set-face-attribute 'default nil
;;   :family "Monaco" :height 180 :weight 'normal)

;; end of custom.el
