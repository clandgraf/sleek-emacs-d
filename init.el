
(add-to-list 'load-path "~/.emacs.d/cla-conf")

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(require 'cla-filehandling)
(require 'cla-gitlab)

(org-babel-load-file "~/.emacs.d/cla-conf/config.org")
