;;; insfactor.el -- Client for a Clojure project with insfactor in it

;; Copyright (C) 2013 John D. Hume

;; Author: John D. Hume <duelin.markers@gmail.com>
;; URL: http://github.com/duelinmarkers/insfactor.el
;; Version: 0.1.0
;; Keywords: clojure
;; Package-Requires: ((nrepl "0.1.8"))

;; This file in not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Index your insfactor-enabled lein project with M-x insfactor-index-project.
;; Ater indexing, find usages with M-x insfactor-find-usages.
;;
;; See http://github.com/duelinmarkers/insfactor for details
;; on setting up your lein project with insfactor.

;;; Code:

(require 'nrepl)

(defun insfactor-index-project ()
  (interactive)
  (nrepl-send-string "(try
                        (require 'duelinmarkers.insfactor.project)
                        (catch Exception e (println e)))"
                     (nrepl-make-response-handler (nrepl-current-repl-buffer)
                                                  (lambda (buffer v) (message "%s" v))
                                                  (lambda (buffer v) (message "%s" v))
                                                  (lambda (buffer v) (message "%s" v))
                                                  (lambda (buffer v) (message "%s" v))))
  (nrepl-send-string "(try
                        (duelinmarkers.insfactor.project/index-project!)
                        (catch Exception e (println e)))"
                     (nrepl-make-response-handler (nrepl-current-repl-buffer)
                                                  (lambda (buffer v) (message "%s" v))
                                                  (lambda (buffer v) (message "%s" v))
                                                  (lambda (buffer v) (message "%s" v))
                                                  (lambda (buffer v) (message "%s" v)))))

(defun insfactor-find-usages (query)
  (interactive "P")
  (nrepl-read-symbol-name "Symbol, keyword, or string literal in \": " 'insfactor-get-usages query))

(defun insfactor-get-usages (expr)
  (let* ((first-char (substring expr 0 1))
         (expr (cond ((or (string= ":" first-char)
                          (string= "\"" first-char))
                      expr)
                     ((string= "'" first-char)
                      (concat "#" expr))
                     (t
                      (concat "#'" expr))))
         (form (format "(do
                          (in-ns '%s)
                          (duelinmarkers.insfactor/find-usages %s))"
                       (nrepl-current-ns)
                       expr)))
    (nrepl-send-string form
                       (insfactor-make-find-usages-handler)
                       nrepl-buffer-ns
                       (nrepl-current-tooling-session))))

(defun insfactor-make-find-usages-handler ()
  (nrepl-make-response-handler (nrepl-make-popup-buffer "Usages")
                               (lambda (buffer value)
                                 (nrepl-popup-buffer-display buffer)
                                 (insfactor-render-find-usages-result
                                  buffer
                                  (first (read-from-string value))))
                               ;; (lambda (buffer out)
                               ;;   (message "out handler: %s" out)
                               ;;   (nrepl-emit-output buffer out t)
                               ;;   (nrepl-popup-buffer-display buffer))
                               nil
                               (lambda (buffer err)
                                 (message "err handler: %s" err)
                                 (nrepl-emit-output buffer err t)
                                 (nrepl-popup-buffer-display buffer))
                               ;; nil
                               nil))

(defun insfactor-render-find-usages-result (buffer data)
  (let* ((title (car data))
         (body
          (apply 'concat (mapcan (lambda (ns-group)
                                   (lexical-let ((ns (car ns-group)))
                                     (mapcar (lambda (loc)
                                               (format "%s:%s: %s"
                                                       ns
                                                       (car loc)
                                                       ;; (car (cdr loc)) column unused
                                                       (shell-command-to-string (format "sed -n '%s,%ss/^[ ]*//p' %s"
                                                                                        (car loc)
                                                                                        (car loc)
                                                                                        ns))))
                                             (cdr ns-group))))
                                 (cdr data))))
         (output (concat title "\n\n" body)))
    (nrepl-emit-into-popup-buffer buffer output)
    (save-excursion
      (with-current-buffer buffer
        (compilation-minor-mode)))))

(provide 'insfactor)

;;; insfactor.el ends here
