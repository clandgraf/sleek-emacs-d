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

(defconst cedm--md-insert-cr-command
  "ceget cdberror %s | jq -r '.[] | [.[\"system:description\"], .[\"system:ui_link\"]] | \"[\\(.[0])](\\(.[1]))\"'")

(defun cedm-md-insert-change-request (cr)
  (interactive
   (list (read-string "Change Request ID: ")))
  (if (not (string-match-p "^E[0-9]\\{6\\}$" cr))
      (error "'%s' is no valid Change Reques  ID."))
  (insert
   (string-trim-right
    (shell-command-to-string
     (format cedm--md-insert-cr-command cr)))))

(defconst cedm--md-insert-person-command
  "ceget person %s | jq -r '.[0][\"system:description\"]'")

(defun cedm-md-insert-person (person)
  (interactive
   (list (read-string "Person ID: ")))
  (insert
   (string-trim-right
    (shell-command-to-string
     (format cedm--md-insert-person-command person)))))

(provide 'cedm)
