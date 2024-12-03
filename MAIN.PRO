% Domains Declaration
domains
    dish = symbol                % Dish is of type symbol
    ingredient = symbol          % Ingredient is of type symbol
    preference_type = symbol     % Preference is of type symbol (vegetarian/non_vegetarian)

% Predicates Declaration
predicates
    dish(dish, preference_type)                % Relationship between dish and preference
    ingredient_for_dish(dish, ingredient)      % Relationship between dish and its ingredients
    recommend(dish, preference_type, ingredient) % Recommend a dish based on preference and allergy
    not_allergic(dish, ingredient)             % Check if a dish is safe based on allergies
    complementary(dish, dish)                  % Complementary dishes (like pizza and salad)
    suggest_complementary(dish, dish)          % Suggest a complementary dish
    query                                      % Main query for interacting with the user
    handle_preference(string, preference_type) % Handle the user's preference input
    handle_allergy(string, ingredient)         % Handle the user's allergy input
    recommend_output(preference_type, ingredient) % Print all recommended dishes

% Clauses (Facts and Rules)

% Dishes and their categories (vegetarian/non-vegetarian)
clauses
    dish("pizza", non_vegetarian).             % Pizza is a non-vegetarian dish
    dish("salad", vegetarian).                 % Salad is a vegetarian dish
    dish("burger", non_vegetarian).            % Burger is a non-vegetarian dish
    dish("pasta", vegetarian).                 % Pasta is a vegetarian dish
    dish("sushi", non_vegetarian).             % Sushi is a non-vegetarian dish
    dish("fruit_salad", vegetarian).           % Fruit salad is a vegetarian dish

% Ingredients for each dish
    ingredient_for_dish("pizza", "cheese").
    ingredient_for_dish("pizza", "tomato").
    ingredient_for_dish("pizza", "dough").
    ingredient_for_dish("pizza", "chicken").

    ingredient_for_dish("salad", "lettuce").
    ingredient_for_dish("salad", "tomato").
    ingredient_for_dish("salad", "cucumber").

    ingredient_for_dish("burger", "bun").
    ingredient_for_dish("burger", "beef").
    ingredient_for_dish("burger", "cheese").
    ingredient_for_dish("burger", "lettuce").

    ingredient_for_dish("pasta", "noodles").
    ingredient_for_dish("pasta", "cheese").
    ingredient_for_dish("pasta", "tomato").
    ingredient_for_dish("pasta", "basil").

    ingredient_for_dish("sushi", "rice").
    ingredient_for_dish("sushi", "fish").
    ingredient_for_dish("sushi", "seaweed").

    ingredient_for_dish("fruit_salad", "apple").
    ingredient_for_dish("fruit_salad", "banana").
    ingredient_for_dish("fruit_salad", "orange").

% Recommend a dish based on user's preference and allergies
    recommend(Dish, Preference, Allergy) :-
        dish(Dish, Preference),
        not_allergic(Dish, Allergy).

% Check if a dish contains any allergic ingredients
    not_allergic(Dish, Allergy) :-
        ingredient_for_dish(Dish, Ingredient),
        Ingredient = Allergy, !, fail.
    not_allergic(_, _).

% Complementary dishes
    complementary("pizza", "salad").
    complementary("salad", "fruit_salad").
    complementary("burger", "fries").
    complementary("pasta", "garlic_bread").

% Suggest complementary dishes
    suggest_complementary(MainDish, ComplementaryDish) :-
        complementary(MainDish, ComplementaryDish).

% Main query logic to interact with the user
    query :-
        write("Welcome to the Restaurant Expert System!"), nl,
        write("Are you vegetarian? (yes/no): "), readln(Input),
        handle_preference(Input, Preference),
        write("Do you have any food allergies? (yes/no): "), readln(AllergyStatus),
        handle_allergy(AllergyStatus, Allergy),
        write("Recommended dishes: "), nl,
        recommend_output(Preference, Allergy).

% Handle the user's food preference (vegetarian/non-vegetarian)
    handle_preference("yes", vegetarian).
    handle_preference("no", non_vegetarian).

% Handle the user's allergy input
    handle_allergy("yes", Allergies) :-
        write("Enter allergen (e.g., fish): "), readln(Allergen),
        Allergies = Allergen.

    handle_allergy("no", "none").

% Print recommended dishes
    recommend_output(Preference, Allergy) :-
        recommend(Dish, Preference, Allergy),
        write(Dish), nl,
        fail.
    recommend_output(_, _).

% Goal for the system to start
goal
    query.    % The goal is to run the main query to start the system
