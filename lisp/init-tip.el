;;; 'wen-tip.el' --- Emacs Wen tip.

(defvar wen-tips
  '("Press <C-x C-r> to open recent files."
    ;; git
    "Press <C-x g> to show current git repo status."
    "Press <C-x v g> to toggle git gutter."
    "Press <C-x v => to pop gutter hunk."
    "Press <C-x v p> to jump previous gutter hunk."
    "Press <C-x v n> to jump next gutter hunk."
    "Press <C-x v s> to stage current hunk."
    "Press <C-x v r> to revert current hunk."
    "Press <C-c o> to open a line."
    "Press <C-c O> to open a line at above."
    "Press <C-c dd> to kill whole special lines."
    "Press <C-c x> to kill whole word."
    "Press <C-\\> to toggle default input method."
    ;; "Press <C-M-;> to toggle pinyin full or width punctuation."
    "Press <C-c b> to switch org buffer."
    "Press <C-c s g> to search in Google."
    "Press <C-c M-\\> to call youdao dict."
    ;; org
    "Press <C-c l> to store org link."
    "Press <C-c a> to open org agenda."
    "Press <C-c c> to open org capture."
    "Press <C-c f> to recursively toggle node in org mode."
    "Press <C-c F> to toggle all nodes in org mode."
    "Press <M-\%> to replace in query mode."
    "Press <C-M-\%> to regexp replace in query mode."
    "Press <M-?> to search input key by ag."
    ;; avy
    "Press <M-g w> to jump the input char in line."
    "Press <M-g f> to jump the input char in file."
    "Press <M-g g> to jump the specail line."
    "Press <M-g C-y> to copy the specail line."
    "Press <M-g C-k> to move the special line."
    "Press <M-g M-y> to copy the special region."
    ;; multi-cursors
    "Press <C-S-c C-S-c> to edit the marked lines into multi cursors."
    "Press <C-\>> to mark the next line like this."
    "Press <C-\<> to mark the previous line like this."
    "Press <C-c C-s> to skip and mark next line like this."
    "Press <C-=> to expand region."
    "Press <M-/> to call hippie expand."
    "Press <M-C-/> to call company complete."
    ;; frame opacity
    "Press <M-C-8> to reduce opacity, step is 2."
    "Press <M-C-9> to increase opacity, step is 2."
    "Press <M-C-0> to reset opacity."
    ;; whole-line-or-region
    "Press <M-;> to comment or uncomment special lines."
    "Press <M-w> to kill whole line or marked region."
    "Press <M-y> to list kill ring."
    ;; easy-kill
    "Press <M-m w> to save word at point."
    "Press <M-m s> to save sexp at point."
    "Press <M-m l> to save list at point."
    "Press <M-m d> to save current function."
    "Press <M-m D> to save current function name."
    "Press <M-m b> to save buffer file name or default directory."
    "Press <M-m @> to append selection to previous kill and exit."
    "Press <M-m C-w> to kill selection and exit."
    "Press <M-m +> to expand selection."
    "Press <M-m -> to shrink slection."
    "Press <M-m 0> to shrink the selection to the inititial size."
    "Press <M-m C-SPC> to turn slection into an active region."
    "Press <M-m C-g> to abort it."
    "Press <M-m s s> to search the point world by swiper."
    ;; multi-term
    "Press <C-c M-t> to open multi term."
    "Press <C-c M-e> to send ESC in multi term."
    "Press <C-c M-[> to jump previous multi term."
    "Press <C-c M-]> to jump next multi term."
    ;; ace-window
    "Press <M-u> to jump window."
    "Press <M-u x> delete window in ace."
    "Press <M-u m> to swap window in ace."
    "Press <M-u n> to select the previous window."
    "Press <M-u v> to split window in vert mode."
    "Press <M-u b> to split window in horiz mode."
    "Press <M-u i> to maximize window."
    "Press <M-u o> to delete all other windows."
    ;; golang
    "Press <C-c C-f> to call gofmt."
    "Press <C-c C-k> to call godoc."
    "Press <C-c C-a> to import package."
    "Press <C-c C-r> to remove unused imports."
    "Press <C-c C-g> to goto imports."
    "Press <C-c C--> to direx pop to buffer."
    ;; help
    "Press <f1 f> to describe function."
    "Press <f1 v> to describe variable."
    "Press <f1 l> to describe library."
    "Press <f2 i> to show symbol info."
    "Press <f2 u> to show unicode."
    "Access the official Emacs manual by pressing <C-h r>."
    "Visit the EmacsWiki at http://emacswiki.org to find out even more about Emacs."))

(defun wen-tip-of-the-day ()
  "Display a random entry from `wen-tips'."
  (interactive)
  (when (and wen-tips (not (window-minibuffer-p)))
    ;; pick a new random seed
    (random t)
    (message
     (concat "Wen tip: " (nth (random (length wen-tips)) wen-tips)))))

(defun wen-eval-after-init (form)
  "Add `(lambda () FORM)' to `after-init-hook'.

    If Emacs has already finished initialization, also eval FORM immediately."
  (let ((func (list 'lambda nil form)))
    (add-hook 'after-init-hook func)
    (when after-init-time
      (eval form))))

(provide 'init-tip)
