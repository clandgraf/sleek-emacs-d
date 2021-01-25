;; -*- lexical-binding: t -*-

(defun cla/git-remote ()
  (substring (shell-command-to-string "git config --get remote.origin.url") 0 -1))

(defun cla/git-branch ()
  (substring (shell-command-to-string "git rev-parse --abbrev-ref HEAD") 0 -1))

(defun cla/git-file-path ()
  (file-relative-name buffer-file-name (vc-root-dir)))

(defun cla/--remove-trailing-dotgit (path)
  (if (string-match "\\.git$" path)
      (replace-match "" nil nil path)))

(defun cla/get-gitlab-file ()
  (let ((remote (cla/git-remote))
        (branch (cla/git-branch))
        (path (cla/git-file-path)))
    (format "%s/-/blob/%s/%s#L%s"
            (cla/--remove-trailing-dotgit remote)
            branch
            path
            (line-number-at-pos))))

(defun cla/view-gitlab-file ()
  (interactive)
  (browse-url
   (cla/get-gitlab-file)))

(defun cla/copy-gitlab-file-to-clipboard ()
  (interactive)
  (let ((gitlab-url (cla/get-gitlab-file)))
    (kill-new gitlab-url)
    (message "Copied '%s' to the clipboard." gitlab-url)))

(defun cla/copy-gitlab-file-to-clipboard-md ()
  (interactive)
  (let ((gitlab-url (format "[%s](%s)" (cla/git-file-path) (cla/get-gitlab-file))))
    (kill-new gitlab-url)
    (message "Copied '%s' to the clipboard." gitlab-url)))

(global-set-key (kbd "<f8>") 'cla/copy-gitlab-file-to-clipboard)
(global-set-key (kbd "M-<f8>") 'cla/copy-gitlab-file-to-clipboard-md)
(global-set-key (kbd "C-<f8>") 'cla/view-gitlab-file)

(provide 'cla-gitlab)
