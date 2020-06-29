var quotes = {
	"And Darkness and Decay and the Red Death held illimitable dominion over all.": "Edgar Allen Poe, The Masque of the Red Death",
	"One Ring to rule them all, One Ring to find them,<br/>One Ring to bring them all, and in the darkness bind them.": "J.R.R. Tolkien, The Fellowship of the Ring"
}

var keys = Object.keys(quotes);
key = keys[keys.length * Math.random() << 0];
document.getElementById("bquotebody").innerHTML = key;
document.getElementById("bquoteauthor").innerHTML = "—" + quotes[key].replace(/(.*, )(.*)/, "$1<cite>$2") + "</cite>";
