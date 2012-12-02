# options
set mbox_type   = Maildir               # mailbox type
set folder      = ~/.mail_iv597         # root folder
set spoolfile   = "+INBOX"              # inbox
set postponed   = "+Drafts"             # [Gmail]/Drafts
unset record                            # required to prevent duplicates in Sent

set sendmail    = "/usr/sbin/sendmail -C/etc/ssmtp/ssmtp_iv597.conf -oem -oi"

# mailboxes
mailboxes +INBOX +freelance +robotics +feeds +cl-comp-gigs +aur-general +arch-bbs +Drafts

# bindings
macro index D "<save-message>+Trash<enter>"   "move message to the trash"
macro index S "<save-message>+Spam<enter>"    "mark message as spam"

# main options
set realname            = "Josh Klar"                       # who am i?
set from                = "j@iv597.com"            # who am i?
set envelope_from                                       # which from?
set mail_check          = 0                             # check for mail always
unset move                                              # gmail does that
#set delete                                              # don't ask, just do
unset confirmappend                                     # don't ask, just do!
unset mark_old                                          # read/new is good enough for me

# index options
set sort                = threads                       # like gmail 
set sort_aux            = reverse-last-date-received    # like gmail
set sort_re                                             # thread based on reply_regexp

# pager
set pager_index_lines   = 8                             # show 8 messages when in pager
set pager_context       = 5                             # show five lines when skipping in pager
set pager_stop                                          # don't go to next message automatically
set menu_scroll                                         # scroll in menus 
set smart_wrap                                          # don't split words
set tilde                                               # show tildes like in vim
unset markers                                           # no ugly plus signs

# composing mail
set fcc_attach                                          # save attachments with the body
unset mime_forward                                      # forward attachments as part of body
set forward_format      = "Fwd: %s"                     # format for subject when forwarding
set include                                             # include message in replies
set forward_quote                                       # include message in forwards
set editor              = vim                           # Fuck beep-repeatedly VI...

# headers to show
ignore *                                                # ignore all headers
unignore from: to: cc: date: subject:                   # show only these
hdr_order from: to: cc: date: subject:                  # and in this order

set sidebar_width=20
set sidebar_visible=yes
set sidebar_delim='|'
#set sidebar_sort=yes
#source /home/j/.mutt_colors

color sidebar_new blue default
bind index \Cp sidebar-prev
bind index \Cn sidebar-next
bind index \Co sidebar-open
bind pager \Cp sidebar-prev
bind pager \Cn sidebar-next
bind pager \Co sidebar-open

