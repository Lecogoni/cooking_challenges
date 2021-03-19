const searchBtn = document.getElementById('search-btn');
const mealList = document.getElementById('meal');
const mealDetailsContent = document.querySelector('.meal-details-content');
const recipeCloseBtn = document.getElementById('reipe-close-btn');

searchBtn.addEventListener("click", getMealList);

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

function getMealList(){
    let searchInputTxt = document.getElementById('search-input').value.trim();
    console.log(searchInputTxt);
    fetch(`https://www.themealdb.com/api/json/v1/1/filter.php?c=${searchInputTxt}`)
    .then(response => response.json())
    .then(data => {
        let dataMeal = data.meals[getRandomInt(data.meals.length)]
        console.log(dataMeal)
        console.log(data.meals.length)
        let html = "";
        if (data.meals) {
            html += `
                <div class="container meal-result">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                        <div class="col">
                            <h1 class="fw-light"> Ta recette 🤩 </h1>
                            <div class="card shadow-sm" id="meal">
                                <img src="${dataMeal.strMealThumb}" alt="Meal Img"/>
                                <div class="card-body">
                                    <p class="card-text meal_item"><strong>${dataMeal.strMeal}</strong></p>
                                    <p class="card-text meal_item">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-sm btn-outline-secondary">Voir plus</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> 
                </div>
            `; 
        };
        mealList.innerHTML = html;
    });
}