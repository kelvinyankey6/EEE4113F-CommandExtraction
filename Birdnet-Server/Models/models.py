
from typing import Union
from pydantic import BaseModel


class SearchQuery(BaseModel):
    startDate: int
    endDate: int
    limit: int
    skip: int
    minTemp: Union[int, None]
    maxTemp: Union[int, None]
    minHum: Union[int, None]
    maxHum: Union[int, None]


