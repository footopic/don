var marked = require('marked');

$(function() {
    console.log('loaded article_form');
    var $title = $('#article_title');
    var $text_edit = $('#article_text');
    var $text_preview = $('#text-preview-area');
    var $submit_btn = $('#btn-submit');
    var l = localStorage;

    // ローカルストレージに保存されていたら復元
    if (l.getItem("text") != null) {
        var text = l.getItem("text");
        $text_edit.val(text);
    }
    if (l.getItem("title") != null) {
        $title.val(l.getItem("title"));
    }

    if ($text_edit.val() != null) {
        $text_preview.html(marked($text_edit.val()));
    }

    // 変更をマークダウンにしプレビューに反映する
    $text_edit.keyup(function() {
        $text_preview.html(marked($(this).val()));
        l.setItem("text", $(this).val());
    });
    $title.keyup(function() {
        l.setItem("title", $(this).val());
    });

    $submit_btn.click(function() {
        // TODO: validation check
        console.log("checked");
        l.removeItem("text");
        l.removeItem("title");
    });
});
