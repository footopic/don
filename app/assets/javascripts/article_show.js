$(function () {
    $text_preview = $('#text-preview');
    $text_raw = $('#text-raw');

    if ($text_raw.length > 0 && $text_preview.length > 0) {
        $text_preview.html(marked($text_raw.html()));
        $('pre code').each(function(i, block) {
            hljs.highlightBlock(block);
        });
    }
});
