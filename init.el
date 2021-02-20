
;; Set up custom custom file
;;
;; This causes emacs to put custom declarations into an unversioned
;; file as this is annoying with version control

(setq custom-file "~/.emacs.d/emacs-custom.el")
(unless (file-exists-p custom-file)
  (with-temp-buffer (write-file custom-file)))

(load custom-file)

;; Load some custom packages

(add-to-list 'load-path "~/.emacs.d/cla-conf")

(require 'cla-filehandling)
(require 'cla-gitlab)
(require 'wsl)

;; Load my emacs config

(org-babel-load-file "~/.emacs.d/cla-conf/config.org")

;; emacs-local.el contains configuration that is local to this
;; site. This is not under version control

(defvar cla/local-settings-file "~/.emacs.d/emacs-local.el")
(when (file-exists-p cla/local-settings-file)
  (load cla/local-settings-file))
