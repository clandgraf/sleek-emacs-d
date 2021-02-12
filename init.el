
(add-to-list 'load-path "~/.emacs.d/cla-conf")

(setq custom-file "~/.emacs.d/emacs-custom.el")
(unless (file-exists-p custom-file)
  (with-temp-buffer (write-file custom-file)))

(load custom-file)

(require 'cla-filehandling)
(require 'cla-gitlab)

(org-babel-load-file "~/.emacs.d/cla-conf/config.org")
