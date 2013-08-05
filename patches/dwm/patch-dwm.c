--- ./dwm.c.orig	2011-12-19 16:02:46.000000000 +0100
+++ ./dwm.c	2013-08-05 17:31:41.304736695 +0200
@@ -521,6 +521,8 @@
 	XWMHints *wmh;
 
 	c->isurgent = False;
+	if (getenv("BLINK1URGENT") != NULL)
+		system("blink1-tool --off >/dev/null 2>&1");
 	if(!(wmh = XGetWMHints(dpy, c->win)))
 		return;
 	wmh->flags &= ~XUrgencyHint;
@@ -2033,6 +2035,8 @@
 		}
 		else
 			c->isurgent = (wmh->flags & XUrgencyHint) ? True : False;
+		if(c->isurgent && (getenv("BLINK1URGENT") != NULL))
+			system("blink1-tool --blue >/dev/null 2>&1");
 		if(wmh->flags & InputHint)
 			c->neverfocus = !wmh->input;
 		else
