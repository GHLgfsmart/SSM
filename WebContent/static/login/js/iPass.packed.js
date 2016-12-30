(function($) {
    $.fn.iPass = function(options) {
        var settings = {
            'checkInterval': 200,
            'maskDelay': 500,
            'maskChar': '%u25CF'
        };
		/*
        if (options) {
            $.extend(settings, options);
        }
		*/
        var checkTimeout = [];
        var maskTimeout = [];
        var regex = new RegExp('[^' + settings['maskChar'] + ']', 'gi');
        var i = 0;
        this.each(function(index) {
            var suffix = '-' + index;
            var obj = $(this);
            var id = this.id;
            var name = this.name;
            var newId = id + suffix;
            var newName = id + suffix;
            if (!id || !name) {
                alert("You must set 'id' and 'name' attributes for elements!");
                return false
            }
			
			$('<input id="' + newId + '" name="' + newName + '" type="text" autocomplete="off" />').insertAfter(obj);
			
            
            var newObj = $('#' + newId);
            var newElem = $('#' + newId)[0];
            if (this.accessKey) {
                newElem.accessKey = this.accessKey
            }
            if (this.className) {
                newElem.className = this.className
            }
            if (this.disabled) {
                newElem.disabled = this.disabled
            }
            if (this.maxLength && this.maxLength != '-1') {
                newElem.maxLength = this.maxLength
            }
            if (this.readOnly) {
                newElem.readOnly = this.readOnly
            }
            if (this.size) {
                newElem.size = this.size
            }
            if (this.tabIndex) {
                newElem.tabIndex = this.tabIndex
            }
            if (this.title) {
                newElem.title = this.title
            }
            this.accessKey = '';
            this.tabIndex = '';
            obj.hide();
            newObj.bind('focus', function() {
                var oldValue = newObj.val();
                checkTimeout[index] = setTimeout(function() {
                    checkChange(index, id, newId, oldValue)
                }, settings['checkInterval'])
            });
            newObj.bind('blur', function() {
                maskChar(index, newId);
                clearTimeout(checkTimeout[index])
            });
            $('label').each(function() {
                if (this.htmlFor == id) {
                    this.htmlFor = newId
                } else if (obj[0].parentNode.tagName.toLowerCase() == 'label') {
                    obj[0].parentNode.htmlFor = newId
                }
            })
        });
        checkChange = function(index, oldId, id, oldValue) {
            var curValue = $('#' + id).val();
            if (curValue != oldValue) {
                setPass(index, oldId, id)
            } else {
                maskChar(index, id)
            }
            oldValue = curValue;
            checkTimeout[index] = setTimeout(function() {
                checkChange(index, oldId, id, oldValue)
            }, settings['checkInterval'])
        };
        setPass = function(index, oldId, id) {
            var pos = getCurPos(id);
            var lastInputChar = false;
            var inpObj = $('#' + id);
            var passObj = $('#' + oldId);
            var inputChars = inpObj.val().split('');
            var passChars = passObj.val().split('');
            if (maskTimeout[index]) {
                clearTimeout(maskTimeout[index]);
                maskTimeout[index] = null
            }
            for (i = 0; i < inputChars.length; i++) {
                if (inputChars[i] != passChars[i]) {
                    if (inputChars[i] != unescape(settings['maskChar'])) {
                        passChars.splice(i, 0, inputChars[i])
                    } else {
                        passChars[i] = passChars[i]
                    }
                } else {
                    passChars.splice(i, 0, inputChars[i])
                }
            }
            if (inputChars.length < passChars.length) {
                passChars.splice(pos.start, passChars.length - inputChars.length, '')
            }
            for (i = 0; i < inputChars.length; i++) {
                if (inputChars[i] != unescape(settings['maskChar'])) {
                    lastInputChar = i
                }
            }
            for (i = 0; i < inputChars.length; i++) {
                if (i < lastInputChar) {
                    inputChars[i] = unescape(settings['maskChar'])
                }
            }
            inpObj.val(inputChars.join(''));
            passObj.val(passChars.join(''));
            setCurPos(id, pos)
        };
        maskChar = function(index, id) {
            var pos = getCurPos(id);
            var inpObj = $('#' + id);
            var curValue = inpObj.val();
            if (!maskTimeout[index] && curValue.match(regex) != null) {
                maskTimeout[index] = setTimeout(function() {
                    inpObj.val(curValue.replace(regex, unescape(settings['maskChar'])));
                    setCurPos(id, pos)
                }, settings['maskDelay'])
            }
        };
        getCurPos = function(id) {
            var input = $('#' + id)[0];
            var pos = {
                start: 0,
                end: 0
            };
            if (input.setSelectionRange) {
                //pos.start = input.selectionStart;
               // pos.end = input.selectionEnd
            } else if (input.createTextRange) {
                var bookmark = document.selection.createRange().getBookmark();
                var selection = input.createTextRange();
                var before = selection.duplicate();
              /*  selection.moveToBookmark(bookmark);
               before.setEndPoint('EndToStart', selection);
                pos.start = before.text.length;
                pos.end = pos.start + selection.text.length*/
            }
            return pos
        };
		
       
    }
})(jQuery);