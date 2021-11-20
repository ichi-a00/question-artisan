//設問択一用js
function choose_one(already) {
  let choose_one_list = document.querySelectorAll(".choose_one_list");
	for (let i in choose_one_list) {
	  if (choose_one_list.hasOwnProperty(i)) {
	  	choose_one_list[i].checked = false;
	  }
	}
  already.checked = true;
}