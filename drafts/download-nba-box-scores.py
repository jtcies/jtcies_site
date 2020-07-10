from sportsreference.nba.boxscore import Boxscore
from sportsreference.nba.schedule import Schedule
from sportsreference.nba.teams import Teams
import pandas as pd

teams = Teams()

indexes = []

for team in teams:
    games = team.schedule
    for game in games:
        indexes.append(game.boxscore_index)

scores = pd.DataFrame()

for index in indexes:
    score = Boxscore(index)
    df = score.dataframe
    scores = scores.append(df)

scores.to_csv("content/data/nba-boxscores-2020.csv")

phi_sched = Schedule('PHI')

for game in phi_sched:
    print(game.date)


