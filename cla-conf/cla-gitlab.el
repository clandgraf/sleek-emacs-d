;; -*- lexical-binding: t -*-

(defun cla/git-remote ()
  (substring (shell-command-to-string "git config --get remote.origin.url") 0 -1))

(defun cla/git-branch ()
  (substring (shell-command-to-string "git rev-parse --abbrev-ref HEAD") 0 -1))

(defun cla/git-file-path ()
  (file-relative-name buffer-file-name (vc-root-dir)))

(defun cla/--remove-trailing-dotgit (path)
  (if (string-match "\\.git$" path)
      (replace-match "" nil nil path)
    path))

(defun cla/get-gitlab-file ()
  (let ((remote (cla/git-remote))
        (branch (cla/git-branch))
        (path (cla/git-file-path)))
    (format "%s/-/blob/%s/%s#L%s"
            (cla/--remove-trailing-dotgit remote)
            branch
            path
            (line-number-at-pos))))

(defun cla/view-vc-file ()
  (interactive)
  (browse-url
   (cla/get-vc-file)))

(defun cla/copy-vc-file-to-clipboard ()
  (interactive)
  (let ((file-url (cla/get-vc-file)))
    (kill-new file-url)
    (message "Copied '%s' to the clipboard." file-url)))

(defun cla/copy-gitlab-file-to-clipboard-md ()
  (interactive)
  (let ((gitlab-url (format "[%s](%s)" (cla/git-file-path) (cla/get-gitlab-file))))
    (kill-new gitlab-url)
    (message "Copied '%s' to the clipboard." gitlab-url)))

(defun cla/get-svn-url ()
  (substring (shell-command-to-string "svn info --show-item url") 0 -1))

(defun cla/get-svn-file ()
  (format (concat (replace-regexp-in-string "/svn/" "/viewvc/" (cla/get-svn-url))
                  "/"
                  (file-name-nondirectory buffer-file-name)
                  "?view=markup#l%s")
          (line-number-at-pos)))

(defun cla/get-vc-file ()
  (let ((type (vc-backend buffer-file-name)))
    (cond ((string-equal type "SVN") (cla/get-svn-file))
          ((string-equal type "Git") (cla/get-gitlab-file)))))

(global-set-key (kbd "<f8>") 'cla/copy-vc-file-to-clipboard)
(global-set-key (kbd "M-<f8>") 'cla/copy-gitlab-file-to-clipboard-md)
(global-set-key (kbd "C-<f8>") 'cla/view-vc-file)

(provide 'cla-gitlab)
