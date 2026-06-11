;;; cedm.el --- Utilities for CEDM -*- lexical-binding: t -*-

;; Copyright (C) 2022-2024 Free Software Foundation, Inc.

;; Author: Christoph Landgraf <christoph.landgraf@googlemail.com>
;; Maintainer: Christoph Landgraf <christoph.landgraf@googlemail.com>
;; Created: 2024
;; Version: 1.0
;; Package-Requires: ((emacs "29.1") (compat "30"))
;; Homepage: https://github.com/clandgraf/sleek-emacs-d
;; Keywords: integration

;;; Commentary:

;; This provides functions to integrate with cedm.

;;; Code:

(defconst cedm--insert-detail-link-command
  "ceget %s %%s | jq -r '.[] | [.[\"system:description\"], .[\"system:ui_link\"]] | %s'")

(defconst cedm--md-link-pattern
  "\"[\\(.[0])](\\(.[1]))\"")

(defconst cedm--org-link-pattern
  "\"[[\\(.[1])][\\(.[0])]]\"")

(defun cedm--link-pattern ()
  (cond ((derived-mode-p 'org-mode)
         cedm--org-link-pattern)
        ((derived-mode-p 'markdown-mode)
         cedm--md-link-pattern)
        (t
         (error "Unsupported mode"))))

(defun cedm--insert-detail-link (object-class keys)
  (insert
   (string-trim-right
    (shell-command-to-string
     (format (format cedm--insert-detail-link-command object-class (cedm--link-pattern)) keys)))))

(defun cedm-insert-change-request (cr)
  (interactive
   (list (read-string "Change Request ID: ")))
  (if (not (string-match-p "^E[0-9]\\{6\\}$" cr))
      (error "'%s' is no valid Change Request ID."))
  (cedm--insert-detail-link "cdberror" cr))

(defun cedm-md-insert-person (person)
  (interactive
   (list (read-string "Person ID: ")))
  (cedm--insert-detail-link "person" person))

(provide 'cedm)
