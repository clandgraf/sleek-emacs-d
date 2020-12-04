
(defun cla/get-gitlab-file ()
  (format
   "%s/-/blob/%s/%s#L%s"
   (substring (shell-command-to-string "git config --get remote.origin.url") 0 -1)
   (substring (shell-command-to-string "git rev-parse --abbrev-ref HEAD") 0 -1)
   (file-relative-name buffer-file-name (vc-root-dir))
   (line-number-at-pos)))

(defun cla/view-gitlab-file ()
  (interactive)
  (browse-url
   (cla/get-gitlab-file)))

(defun cla/copy-gitlab-file-to-clipboard ()
  (interactive)
  (let ((gitlab-url (cla/get-gitlab-file)))
    (kill-new gitlab-url)
    (message "Copied '%s' to the clipboard." gitlab-url)))

(global-set-key (kbd "<f8>") 'cla/copy-gitlab-file-to-clipboard)
(global-set-key (kbd "C-<f8>") 'cla/view-gitlab-file)

(provide 'cla-gitlab)
