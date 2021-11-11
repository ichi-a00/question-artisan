function radioDeselection(already) {
    let radio_list = document.querySelectorAll(".radio_list");
    for (let i in radio_list) {
			if (radio_list.hasOwnProperty(i)) {
				radio_list[i].checked = false;
			}
		}
		already.checked = true;
}