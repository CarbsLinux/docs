;;; docs.el --- configuration for docs exports
;;; Commentary:
;;; Code:
(require 'org)
(require 'ox)
(require 'ox-ascii)

;; We do NOT want backup files.
(setq make-backup-files nil)

(defun docs-install-txt ()
  "Extract and export installation manual from the User Manual."
  (let ((org-export-with-toc nil))
    (re-search-forward "^* Installation")
    (org-ascii-export-to-ascii nil t)))

(provide 'docs)
;;; docs.el ends here
