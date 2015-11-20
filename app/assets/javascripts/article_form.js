var marked = require('marked');

$(function() {
    var $title = $('#article_title');
    var $text_edit = $('#article_text');
    var $text_preview = $('#text-preview-area');
    var l = localStorage;

    // ローカルストレージに保存されていたら復元
    if (l.getItem("text") != null) {
        var text = l.getItem("text");
        $text_edit.val(text);
        $text_preview.html(marked(text));
    }
    if (l.getItem("title") != null) {
        $title.val(l.getItem("title"));
    }

    // 変更をマークダウンにしプレビューに反映する
    $text_edit.keyup(function() {
        $text_preview.html(marked($(this).val()));
        l.setItem("text", $(this).val());
    });
    $title.keyup(function() {
        l.setItem("title", $(this).val());
    });

});
